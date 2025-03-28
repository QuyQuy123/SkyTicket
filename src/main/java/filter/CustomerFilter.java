package filter;

import java.io.IOException;

import dal.AccountDAO;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;

public class CustomerFilter implements Filter {

    private static final boolean debug = true;
    private FilterConfig filterConfig = null;

    public CustomerFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("CustomerFilter: DoBeforeProcessing");
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("CustomerFilter: DoAfterProcessing");
        }
    }

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("CustomerFilter: doFilter()");
        }

        doBeforeProcessing(request, response);
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        Integer idAccount = (Integer)session.getAttribute("id");

        // Kiểm tra nếu người dùng chưa đăng nhập
        if (idAccount == null) {
            // Lưu lại URL trang hiện tại
            String requestedURL = req.getRequestURL().toString();

            // Lưu URL vào session
            session.setAttribute("prevPage", requestedURL);

            // Chuyển hướng người dùng đến trang login
            res.sendRedirect(req.getContextPath() + "/LoginURL");
        } else {
            // Nếu người dùng đã đăng nhập, tiếp tục xử lý request
            chain.doFilter(request, response);
        }

        doAfterProcessing(request, response);
    }

    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    public void destroy() {
    }

    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("CustomerFilter: Initializing filter");
            }
        }
    }

    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("CustomerFilter()");
        }
        StringBuilder sb = new StringBuilder("CustomerFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return sb.toString();
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
}
