package lk.jiat.app.ejb.bean;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Enumerated;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.model.Status;
import lk.jiat.app.core.model.UserType;
import lk.jiat.app.core.model.User;
import lk.jiat.app.core.service.UserService;

import java.util.List;

@Stateless
public class UserSessionBean implements UserService {

    @PersistenceContext
    private EntityManager em;


    @Override
    public User getUserById(Long id) {
        return em.find(User.class, id);
    }

    @Override
    public User getUserByEmail(String email) {
        return em.createNamedQuery("User.findByEmail", User.class)
                .setParameter("email", email).getSingleResult();
    }

    @Override
    public void addUser(User user) {

        em.persist(user);
    }

    @RolesAllowed({"MANAGER","ADMIN","SUPER_ADMIN"})
    @Override
    public void updateUser(User user) {
        em.merge(user);
    }

    @RolesAllowed({"MANAGER","ADMIN","SUPER_ADMIN"})
    @Override
    public void deleteUser(Long id) {
        em.remove(em.find(User.class, id));
    }

    @Override
    public List<User> getAllUsers() {
        return em.createNamedQuery("User.findAll", User.class)
                .setParameter("type", UserType.CASHIER)
                .getResultList();
    }

    @Override
    public boolean validate(String email, String password) {
        User user = em.createNamedQuery("User.findByEmail", User.class)
                .setParameter("email", email).getSingleResult();

        return user != null && user.getPassword().equals(password);

    }

    @Override
    public boolean cashierLogin(String email, String code) {
        try {
            User user = em.createNamedQuery("User.findByEmail", User.class)
                    .setParameter("email", email)
                    .getSingleResult();

            if (user != null &&
                    user.getUserType().name().equals("CASHIER") &&
                    user.getVerificationCode().equals(code)) {

                //  enum status
                user.setStatus(Status.ACTIVE);
                em.merge(user);
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
