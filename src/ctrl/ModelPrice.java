package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/model_price")
public class ModelPrice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ModelPrice() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String model = request.getParameter("model");
		System.out.println(model);
		
		ModelPriceSvc modelPriceSvc = new ModelPriceSvc();
		int result = modelPriceSvc.getModelPrice(model);
		
		response.setContentType("text/html; charset=utf-8;");
		PrintWriter out = response.getWriter();
		out.println(result);
		
	}

}
