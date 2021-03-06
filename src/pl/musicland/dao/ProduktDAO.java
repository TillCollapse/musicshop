package pl.musicland.dao;

import java.util.List;
import pl.musicland.model.Produkt;

public interface ProduktDAO {

	// Pobiera produkty typu album
	public List<Produkt> getSpecProdAlbum(int cat, int genre);

	// Pobiera produkty typu inne ni� album
	public List<Produkt> getSpecProdOthers(int cat, int prod);

	// pobiera produkt o okre�lonym id
	public Produkt getProduct(int id);

	// Pobiera ilosc wskazanego produktu
	public int getNumberofProd(int id);

	// Zmienjsza ilosc wskazanego produktu w magazynie
	public void decreaseNumberOfProduct(int produktid, int iloscprod);

	public void addProduct(String nazwa, int kategoriaid, int producentid, int gatunekid, int autorid, int ilosc,
			float cena, String opis, String zdjecie);

	public void addProduct(String nazwa, int kategoriaid, int producentid, int ilosc, float cena, String opis,
			String zdjecie);
}
