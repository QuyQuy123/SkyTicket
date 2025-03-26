package controller;

import dal.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "DiscountDelete", value = "/deleteDiscount")
public class DiscountDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirectUrl = request.getContextPath() + "/listDiscounts";
        DiscountDAO discountDAO = new DiscountDAO();
        try {
            String discountIdStr = request.getParameter("discountId");

            if (discountIdStr == null) {
                response.sendRedirect(redirectUrl);
                return;
            }

            int discountId = Integer.parseInt(discountIdStr);
            boolean deleted = discountDAO.deleteDiscount(discountId);

            response.sendRedirect(redirectUrl);

        } catch (NumberFormatException e) {
            response.sendRedirect(redirectUrl);
        } catch (SQLException e) {
            response.sendRedirect(redirectUrl);
            e.printStackTrace();
        } catch (Exception e) {
            response.sendRedirect(redirectUrl);
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}