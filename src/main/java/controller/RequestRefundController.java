package controller;

import dal.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Refund;
import model.Tickets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "RequestRefundController", urlPatterns = {"/requestRefund"})

public class RequestRefundController extends HttpServlet {

    AccountDAO ad = new AccountDAO();
    RefundDAO rd = new RefundDAO();
    TicketsDAO td = new TicketsDAO();
    BookingDAO bd = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        if (idd != null) {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
            response.sendRedirect("ticketHistoryURL");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the form
        String accountHolder = request.getParameter("accountHolder");
        String bank = request.getParameter("bank");
        String bankAccount = request.getParameter("bankAccount");
        String orderCode = request.getParameter("orderCode");
        String amountStr = request.getParameter("amount");
        String ticketIdStr = request.getParameter("ticketId");
        String bookIdStr = request.getParameter("orderId");

        // Debug raw value
        System.out.println("Raw amountStr: " + amountStr);

        Timestamp requestDate = new Timestamp(System.currentTimeMillis());
        Timestamp refundDate = null;

        try {
            // Parse numeric parameters
            int ticketId = Integer.parseInt(ticketIdStr);
            int bookId = Integer.parseInt(bookIdStr);

            // Clean amountStr to remove all non-numeric characters except dot
            String cleanedAmountStr = amountStr != null ? amountStr.replaceAll("[^0-9]", "").trim() : "0";
            System.out.println("Cleaned amountStr: " + cleanedAmountStr); // Debug cleaned value

            // Validate and parse to double
            if (cleanedAmountStr.isEmpty()) {
                cleanedAmountStr = "0"; // Default to 0 if empty after cleaning
            }
            double refundPrice = Double.parseDouble(cleanedAmountStr);

            // Validate required fields
            if (accountHolder == null || accountHolder.trim().isEmpty() ||
                    bank == null || bank.trim().isEmpty() ||
                    bankAccount == null || bankAccount.trim().isEmpty()) {
                request.setAttribute("errorMessage", "All fields (Chủ tài khoản, Ngân hàng, Số tài khoản) are required.");
                request.getRequestDispatcher("/TicketHistory.jsp").forward(request, response);
                return;
            }

            // Create Refund object
            Refund refund = new Refund(ticketId, bankAccount, bank, requestDate, refundPrice, 1, accountHolder);
            int refundId = rd.addRefund(refund);

            if (refundId > 0) {
                // Update ticket and booking statuses to Refund Pending
                List<Tickets> list = td.getAllTicketsByBookingId(bookId);
                for (Tickets ticket : list) {
                    td.waitRefundPendingByTicketId(ticket.getTicketId());
                }
                bd.changeStatusToRefundPending(bookId);
                td.waitRefundPending(bookId);
                response.sendRedirect("requestRefund?success=true");
            } else {
                request.setAttribute("errorMessage", "Failed to process refund request.");
                request.getRequestDispatcher("/TicketHistory.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid input for Ticket ID, Booking ID, or Amount. Cleaned value: " + (amountStr != null ? amountStr.replaceAll("[^0-9.]", "").trim() : "null"));
            request.getRequestDispatcher("/TicketHistory.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing the request.");
            request.getRequestDispatcher("/TicketHistory.jsp").forward(request, response);
        }
    }


}
