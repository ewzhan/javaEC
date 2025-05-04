package Entity;

import Entity.*;
import java.sql.*;
import java.util.*;

public class CartDA {
    private String host      = "jdbc:derby://localhost:1527/assignmentDB";
    private String user     = "nbuser";
    private String password = "nbuser";

    // Obtain a JDBC connection
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(host, user, password);
    }

    /**
     * Return existing cartID for user, or null if none.
     */
    public String getCartId(String customerID) throws SQLException {
        String sql = "SELECT cartID FROM carts WHERE customerID = ?";
        try (Connection c = getConnection();
             PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, customerID);
            try (ResultSet r = p.executeQuery()) {
                if (r.next()) {
                    return r.getString("cartID");
                }
                return null;
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving cart ID: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Generate next CTxxxx ID, insert a new cart row, and return the new ID.
     */
    public String createCart(String userId) throws SQLException {
        Connection c = null;
        PreparedStatement p = null;
        String cartId = null;
        
        try {
            DBConnection db = new DBConnection();
            db.initializeJdbc();
            cartId = db.generateID("CARTS", "CT", 6, 2);
            
            String sql = "INSERT INTO carts VALUES (?, ?)";
            c = getConnection();
            p = c.prepareStatement(sql);
            p.setString(1, cartId);
            p.setString(2, userId);
            
            int rowsAffected = p.executeUpdate();
            System.out.println("Rows inserted: " + rowsAffected);
            return cartId;
        } catch (SQLException e) {
            System.err.println("Error creating cart: " + e.getMessage());
            throw e;
        } finally {
            if (p != null) try { p.close(); } catch (SQLException e) { /* ignore */ }
            if (c != null) try { c.close(); } catch (SQLException e) { /* ignore */ }
        }
    }

    /**
     * Return existing cartID or create a new one.
     */
    public String getOrCreateCartId(String userId) throws SQLException {
        String cartId = getCartId(userId);
        return (cartId != null) ? cartId : createCart(userId);
    }

    /**
     * Add product to cart: increments if exists, else inserts.
     */
    public void addToCart(String userId, String productId, int quantity) throws SQLException {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be positive");
        }
        
        String cartId = getOrCreateCartId(userId);
        boolean productExists = false;
        int existingQuantity = 0;

        // Check if product exists in cart
        String selectSql = "SELECT quantity FROM cartitems WHERE cartID = ? AND productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(selectSql)) {
            ps.setString(1, cartId);
            ps.setString(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    productExists = true;
                    existingQuantity = rs.getInt("quantity");
                }
            }
            
            // Update or insert based on whether product exists
            if (productExists) {
                String updateSql = "UPDATE cartitems SET quantity = ? WHERE cartID = ? AND productID = ?";
                try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                    updatePs.setInt(1, existingQuantity + quantity);
                    updatePs.setString(2, cartId);
                    updatePs.setString(3, productId);
                    updatePs.executeUpdate();
                }
            } else {
                String insertSql = "INSERT INTO cartitems(itemID, cartID, productID, quantity) VALUES(?,?,?,?)";
                try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                    DBConnection db = new DBConnection();
                    db.initializeJdbc();
                    String itemId = db.generateID("CartItems", "CI", 6, 2);
                    insertPs.setString(1, itemId);
                    insertPs.setString(2, cartId);
                    insertPs.setString(3, productId);
                    insertPs.setInt(4, quantity);
                    insertPs.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding product to cart: " + e.getMessage());
            throw e;
        }
    }
    
        public void addToCart2(String userId, String productId, int quantity, String cartId) throws SQLException {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be positive");
        }
        
        boolean productExists = false;
        int existingQuantity = 0;

        // Check if product exists in cart
        String selectSql = "SELECT quantity FROM cartitems WHERE cartID = ? AND productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(selectSql)) {
            ps.setString(1, cartId);
            ps.setString(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    productExists = true;
                    existingQuantity = rs.getInt("quantity");
                }
            }
            
            // Update or insert based on whether product exists
            if (productExists) {
                String updateSql = "UPDATE cartitems SET quantity = ? WHERE cartID = ? AND productID = ?";
                try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                    updatePs.setInt(1, existingQuantity + quantity);
                    updatePs.setString(2, cartId);
                    updatePs.setString(3, productId);
                    updatePs.executeUpdate();
                }
            } else {
                String insertSql = "INSERT INTO cartitems(itemID, cartID, productID, quantity) VALUES(?,?,?,?)";
                try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                    DBConnection db = new DBConnection();
                    db.initializeJdbc();
                    String itemId = db.generateID("CartItems", "CI", 6, 2);
                    insertPs.setString(1, itemId);
                    insertPs.setString(2, cartId);
                    insertPs.setString(3, productId);
                    insertPs.setInt(4, quantity);
                    insertPs.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding product to cart: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Load all items from the user's cart into the Cart model.
     */
    public Cart getUserCart(String userId) throws SQLException {
        Cart cart = new Cart();
        String cartId = getCartId(userId);
        if (cartId == null) return cart;  // empty cart

        String sql =
            "SELECT ci.productID, p.productname, p.productprice, ci.quantity, p.productdesc, p.productimg " +
            "FROM cartitems ci " +
            "JOIN product p ON ci.productID = p.productid " +
            "WHERE ci.cartID = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                        rs.getString("productID"),
                        rs.getString("productname"),
                        rs.getInt("productprice"),
                        rs.getString("productdesc"),
                        rs.getString("productimg")
                    );
                    
                    int qty = rs.getInt("quantity");
                    cart.addItem(p, qty);
                }
            }
            return cart;
        } catch (SQLException e) {
            System.err.println("Error retrieving user cart: " + e.getMessage());
            throw e;
        }
    }
    
    public void updateUserCart(String userId, Cart updatedCart) throws SQLException {
        String cartId = getCartId(userId);
        if (cartId == null) {
            throw new SQLException("Cart not found for user: " + userId);
        }
        
        try (Connection conn = getConnection()) {
            // Step 1: Delete the selected items from cartItems
            String deleteSQL = "DELETE FROM cartItems WHERE cartID = ? AND productID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteSQL)) {
                for (CartItem item : updatedCart.getItems()) {
                    stmt.setString(1, cartId);
                    stmt.setString(2, item.getProduct().getProductid());
                    stmt.addBatch();
                }
                stmt.executeBatch();
            }
        } catch (SQLException e) {
            System.err.println("Error updating user cart: " + e.getMessage());
            throw e;
        }
    }
    
    public boolean updateCart(String cartID, Cart cart) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);  // Start transaction

            // First, delete all existing cart items for this cart
            String deleteSQL = "DELETE FROM cart_items WHERE cart_id = ?";
            pstmt = conn.prepareStatement(deleteSQL);
            pstmt.setString(1, cartID);
            pstmt.executeUpdate();
            pstmt.close();

            // Then insert all current items
            CartItem[] items = cart.getItems();
            if (items != null && items.length > 0) {
                String insertSQL = "INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(insertSQL);

                for (CartItem item : items) {
                    pstmt.setString(1, cartID);
                    pstmt.setString(2, item.getProduct().getProductid());
                    pstmt.setInt(3, item.getQuantity());
                    pstmt.addBatch();
                }

                pstmt.executeBatch();
            }

            conn.commit();  // Commit transaction
            success = true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();  // Rollback in case of error
                } catch (SQLException ex) {
                    throw new SQLException("Error during rollback: " + ex.getMessage());
                }
            }
            throw new SQLException("Failed to update cart: " + e.getMessage());
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    // Log error
                }
            }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    // Log error
                }
            }
        }

        return success;
    }

    /**
     * Update quantity, or remove if newQty &le; 0.
     */
    public void updateQuantity(String userId, String productId, int newQty) throws SQLException {
        if (newQty <= 0) {
            removeFromCart(userId, productId);
            return;
        }
        
        String cartId = getCartId(userId);
        if (cartId == null) return;

        String sql = "UPDATE cartitems SET quantity = ? WHERE cartID = ? AND productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newQty);
            ps.setString(2, cartId);
            ps.setString(3, productId);
            int rowsUpdated = ps.executeUpdate();
            
            if (rowsUpdated == 0) {
                System.out.println("No rows updated. Item may not exist in cart.");
            }
        } catch (SQLException e) {
            System.err.println("Error updating quantity: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Remove an item row.
     */
    public void removeFromCart(String userId, String productId) throws SQLException {
        String cartId = getCartId(userId);
        if (cartId == null) return;
        
        String sql = "DELETE FROM cartitems WHERE cartID = ? AND productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cartId);
            ps.setString(2, productId);
            int rowsDeleted = ps.executeUpdate();
            
            if (rowsDeleted == 0) {
                System.out.println("No rows deleted. Item may not exist in cart.");
            }
        } catch (SQLException e) {
            System.err.println("Error removing item from cart: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Clear all items in cart.
     */
    public void clearCart(String userId) throws SQLException {
        String cartId = getCartId(userId);
        if (cartId == null) return;
        
        String sql = "DELETE FROM cartitems WHERE cartID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cartId);
            int rowsDeleted = ps.executeUpdate();
            System.out.println("Cleared " + rowsDeleted + " items from cart");
        } catch (SQLException e) {
            System.err.println("Error clearing cart: " + e.getMessage());
            throw e;
        }
    }

}