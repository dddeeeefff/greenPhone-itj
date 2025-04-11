package vo;

import java.util.ArrayList;

public class SellCart {
	private int sc_idx, po_idx, sc_cnt;
	private String mi_id, pi_id, sc_date;
	private int pi_min, pi_dc, po_stock, po_inc;
	private String po_name, pi_img1, pi_name;
	private ArrayList<ProductOption> optionList;
	
	public int getPo_inc() {
		return po_inc;
	}
	public void setPo_inc(int po_inc) {
		this.po_inc = po_inc;
	}
	public int getSc_idx() {
		return sc_idx;
	}
	public void setSc_idx(int sc_idx) {
		this.sc_idx = sc_idx;
	}
	public int getPo_idx() {
		return po_idx;
	}
	public void setPo_idx(int po_idx) {
		this.po_idx = po_idx;
	}
	public int getSc_cnt() {
		return sc_cnt;
	}
	public void setSc_cnt(int sc_cnt) {
		this.sc_cnt = sc_cnt;
	}
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getSc_date() {
		return sc_date;
	}
	public void setSc_date(String sc_date) {
		this.sc_date = sc_date;
	}
	public int getPi_min() {
		return pi_min;
	}
	public void setPi_min(int pi_min) {
		this.pi_min = pi_min;
	}
	public int getPi_dc() {
		return pi_dc;
	}
	public void setPi_dc(int pi_dc) {
		this.pi_dc = pi_dc;
	}
	public int getPo_stock() {
		return po_stock;
	}
	public void setPo_stock(int po_stock) {
		this.po_stock = po_stock;
	}
	public String getPo_name() {
		return po_name;
	}
	public void setPo_name(String po_name) {
		this.po_name = po_name;
	}
	public String getPi_img1() {
		return pi_img1;
	}
	public void setPi_img1(String pi_img1) {
		this.pi_img1 = pi_img1;
	}
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	public ArrayList<ProductOption> getOptionList() {
		return optionList;
	}
	public void setOptionList(ArrayList<ProductOption> optionList) {
		this.optionList = optionList;
	}
	
}
