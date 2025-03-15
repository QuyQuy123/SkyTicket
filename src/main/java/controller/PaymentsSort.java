package controller;


import dal.PaymentsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Payments;

import java.io.IOException;
import java.util.List;
    @WebServlet("/sortPayments")
    public class PaymentsSort extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String sortBy = request.getParameter("sortBy");
            String order = request.getParameter("order");

            List<Payments> listPayments = new PaymentsDAO().getAllPayments();

            if ("date".equals(sortBy)) {
                listPayments.sort((p1, p2) -> "asc".equals(order)
                        ? p1.getPaymentDate().compareTo(p2.getPaymentDate())
                        : p2.getPaymentDate().compareTo(p1.getPaymentDate()));
            } else if ("price".equals(sortBy)) {
                listPayments.sort((p1, p2) -> "asc".equals(order)
                        ? Double.compare(p1.getTotalPrice(), p2.getTotalPrice())
                        : Double.compare(p2.getTotalPrice(), p1.getTotalPrice()));
            }

            request.setAttribute("payment", listPayments);
            request.getRequestDispatcher("views/admin/jsp/viewListPayments.jsp").forward(request, response);
        }
    }
