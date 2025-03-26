package controller;

import dal.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Discounts;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "DiscountUpdate", value = "/updateDiscount")
public class DiscountUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private static final double PERCENT_STEP = 0.5; // STEP cho percent (double)
    private static final int POINTS_STEP = 5;       // STEP cho points (int)
    private static final double MAX_PERCENT = 100.0;
    private static final double MIN_VALUE = 0.0;

    // Giả sử bạn có một DAO để xử lý database
     private DiscountDAO discountDAO = new DiscountDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirectUrl = request.getContextPath() + "/listDiscounts";

        try {
            // Validation input
            String discountIdStr = request.getParameter("discountId");
            String field = request.getParameter("field");
            String action = request.getParameter("action");

            if (discountIdStr == null || field == null || action == null) {
                response.sendRedirect(redirectUrl);
                return;
            }

            int discountId = Integer.parseInt(discountIdStr);
            Discounts discount = discountDAO.getDiscountById(discountId);

            if (discount == null) {
                response.sendRedirect(redirectUrl);
                return;
            }

            boolean isUpdated = false;
            if ("percent".equals(field)) {
                double currentPercent = discount.getPercent();
                if ("increase".equals(action) && currentPercent < MAX_PERCENT) {
                    double newPercent = Math.min(currentPercent + PERCENT_STEP, MAX_PERCENT);
                    discount.setPercent(newPercent);
                    isUpdated = true;
                } else if ("decrease".equals(action) && currentPercent > MIN_VALUE) {
                    double newPercent = Math.max(currentPercent - PERCENT_STEP, MIN_VALUE);
                    discount.setPercent(newPercent);
                    isUpdated = true;
                } else if ("set".equals(action)) {
                    String valueStr = request.getParameter("value");
                    if (valueStr != null) {
                        double newPercent = Double.parseDouble(valueStr);
                        if (newPercent >= MIN_VALUE && newPercent <= MAX_PERCENT) {
                            discount.setPercent(newPercent);
                            isUpdated = true;
                        }
                    }
                }
            } else if ("points".equals(field)) {
                int currentPoints = discount.getPoints();
                if ("increase".equals(action)) {
                    discount.setPoints(currentPoints + POINTS_STEP);
                    isUpdated = true;
                } else if ("decrease".equals(action) && currentPoints > MIN_VALUE) {
                    int newPoints = Math.max(currentPoints - POINTS_STEP, (int)MIN_VALUE);
                    discount.setPoints(newPoints);
                    isUpdated = true;
                } else if ("set".equals(action)) {
                    String valueStr = request.getParameter("value");
                    if (valueStr != null) {
                        int newPoints = Integer.parseInt(valueStr);
                        if (newPoints >= MIN_VALUE) {
                            discount.setPoints(newPoints);
                            isUpdated = true;
                        }
                    }
                }
            } else {
                response.sendRedirect(redirectUrl);
                return;
            }

            if (isUpdated) {
                discountDAO.discountUpdate(discount);
            }

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
}