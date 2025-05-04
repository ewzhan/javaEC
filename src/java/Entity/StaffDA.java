package Entity;
import java.sql.*;
import java.util.*;
import Entity.*;
import javax.persistence.*;
import javax.transaction.UserTransaction;
import javax.swing.*;
public class StaffDA {
    private EntityManager em;
    private UserTransaction utx;

    public StaffDA(EntityManager em, UserTransaction utx) {
        this.em = em;
        this.utx = utx;
    }

    public boolean isLoginValid(String email, String password) {
        try {
            Query query = em.createNamedQuery("Staff.findByEmail", Staff.class);
            query.setParameter("email", email);
            Staff staff = (Staff) query.getSingleResult();

            if (staff != null) {
                System.out.print("Success find staff email");
                System.out.print(staff);
                System.out.print(PasswordUtils.hashPassword(password).substring(0, Math.min(PasswordUtils.hashPassword(password).length(), 20)));
                return PasswordUtils.hashPassword(password).substring(0, Math.min(PasswordUtils.hashPassword(password).length(), 20)).equals(staff.getPassword());
            }
        } catch (NoResultException e) {
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public Staff getStaffByEmail(String email) {
        return em.createQuery("SELECT s FROM Staff s WHERE s.email = :email", Staff.class)
                 .setParameter("email", email)
                 .getSingleResult();
    }
    public boolean compareStaffEmail(String email) {
        try {
            Query query = em.createNamedQuery("Staff.findByEmail", Staff.class);
            query.setParameter("email", email);
            Staff staff = (Staff) query.getSingleResult();
            return staff != null;
        } catch (NoResultException e) {
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email.matches(emailRegex);
    }

    public boolean compareStaffIC(String ic) {
        try {
            ic = ic.replace("-", "");
            Query query = em.createNamedQuery("Staff.findByIc", Staff.class);
            query.setParameter("ic", ic);
            Staff staff = (Staff) query.getSingleResult();
            return staff != null;
        } catch (NoResultException e) {
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean compareStaffIC(String ic, String email) throws Exception {
        try {
            ic = ic.replace("-", "");
            TypedQuery<Staff> query = em.createQuery(
                "SELECT s FROM Staff s WHERE s.ic = :ic AND s.email <> :email", Staff.class
            );
            query.setParameter("ic", ic);
            query.setParameter("email", email);

            Staff staff = query.getSingleResult();
            return staff != null;
        } catch (NoResultException e) {
            return false;
        } catch (Exception e) {
            throw new Exception("Error while checking IC: " + e.getMessage());
        }
    }

    public boolean isPhoneUsedByOtherStaff(String phone, String currentEmail) throws Exception {
    Query query = em.createQuery(
        "SELECT s FROM Staff s WHERE s.phoneno = :phone AND s.email <> :email", Staff.class);
    query.setParameter("phone", phone);
    query.setParameter("email", currentEmail);
    return !query.getResultList().isEmpty();
}
public Staff findStaffByEmail(String email) throws Exception {
    TypedQuery<Staff> query = em.createNamedQuery("Staff.findByEmail", Staff.class);
    query.setParameter("email", email);
    
    List<Staff> results = query.getResultList();
    if (results.isEmpty()) {
        return null; // No staff found with this email
    }
    return results.get(0); // Return the matching staff
}

    public void updateStaffDetails(String email, String name, String phone, String ic, String address) {
        try {
            utx.begin();
            Query query = em.createNamedQuery("Staff.findByEmail", Staff.class);
            query.setParameter("email", email);

            Staff existingStaff = (Staff) query.getSingleResult();

            if (existingStaff != null) {
                existingStaff.setStaffname(name);
                existingStaff.setIc(ic.replace("-", ""));
                existingStaff.setPhoneno(phone);
                existingStaff.setHomeaddress(address);
                em.merge(existingStaff);
                utx.commit();
            }
        } catch (Exception e) {
            try {
                if (utx != null && utx.getStatus() == javax.transaction.Status.STATUS_ACTIVE) {
                    utx.rollback();
                }
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
    }
}
