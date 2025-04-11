package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/sell_index")
public class SellIndexCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SellIndexCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("sell/sell_index.jsp");
		dispatcher.forward(request, response);
	}

}
