<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<?xml version="1.0" encoding="UTF-8" ?>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>

<html>
	<head>
		<title>STRONA GlOWNA</title>
		<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
		<link href="<c:url value="/resources/css/menuleft.css" />" rel="stylesheet">
		<link href="<c:url value="/resources/css/menutop.css" />" rel="stylesheet">
		<link href="<c:url value="/resources/css/obrazki.css" />" rel="stylesheet">
		<link href="<c:url value="/resources/css/table.css" />" rel="stylesheet">
		<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
		
		<script src="<c:url value="/resources/js/jquery-2.1.3.js" />"></script>
		<script src="<c:url value="/resources/js/loadpage.js" />"></script> 
		
	</head>

	<body>
		<div id="tytul">
			<h1>MUSIC LAND</h1>
		</div>
		<div id="log">
			<c:if test="${pageContext.request.userPrincipal.name != null}">
				<p>
					Witaj : ${username} | <a href="javascript:formSubmit()"> Wyloguj</a>
				</p>
			</c:if> 
			<c:if test="${pageContext.request.userPrincipal.name == null}">
				<a href="#" onClick=loadPage("panel","<c:url value="/login"/>")>Zaloguj</a>
				<a href="#" onClick=loadPage("panel","<c:url value="/register"/>")>Rejestracja</a>
			</c:if>	
		</div>
                
		 <div id="panel">
		 	<c:if test="${pageContext.request.userPrincipal.name != null}">
	            <div>
	           		<a href="#" onClick =loadPage("prawy","<c:url value="/basket"/>")><img src="<c:url value="resources/icons/trolley.png" />" id="koszykimg" /></a>
	            </div>
       		</c:if> 
                    
			<div id="naglowek">
				<div id="menutop">
					<ul>
                                            <li><a href="">Home</a></li>
                                            <li><a href="#" onClick=loadPage("prawy","<c:url value="/resources/template/kontakt.html" />")>Kontakt</a></li>
                                            <li><a href="#" onClick=loadPage("prawy","<c:url value="/resources/template/zasady.html" />")>Zasady</a></li>
											<sec:authorize url="/adminAddProd">
					                        	<li><a href="<c:url value="/adminAddProd" />">Panel administracyjny</a></li>
											</sec:authorize>
					</ul>
				</div>
			</div>

                     
			<div id="lewy">
                            
				<div id="menuleft">
					<label>Kategorie</label>
		                <ul>
			           		<c:forEach var="catname" items="${catnameList}">
				           		<li>${catname.nazwa_kategorii}
				           		
					                <ul>
					                
										<c:forEach var="genre" items="${genreList}">
											<c:if test="${catname.nazwa_kategorii == genre.nazwa_kategorii}">
						                		<li><a href="<c:url value="/products?genre=${genre.gatunekid}&cat=${genre.kategoriaid}"/>">${genre.nazwa_gatunku}</a> </li>
						                	</c:if>
						                </c:forEach>
					
					          		</ul>
			
							</c:forEach>
			               		</li>
			                
			             
			                 <c:forEach var="catname" items="${catnameList2}">
				           		<li>${catname.nazwa_kategorii}
				           		
					                <ul>
					                
										<c:forEach var="produ" items="${genreList2}">
											<c:if test="${catname.nazwa_kategorii == produ.nazwa_kategorii}">
						                		<li><a href="<c:url value="/products2?produ=${produ.producentid}&cat=${produ.kategoriaid}"/>">${produ.nazwa_producenta}</a> </li>
						                	</c:if>
						                </c:forEach>
					
					          		</ul>
			
							</c:forEach>
			               		</li>
							
						</ul>
				</div>
			</div>
			<div id="prawy">
				<c:forEach var="tmp" items="${productsList}" >
					<form class="productForm" method="POST" id="addProd${tmp.produktid}">       
		                <div id="obrazki">
		                	<a href="<c:url value="/prodspec?id=${tmp.produktid}" />"><img src="<c:url value="/resources/pictures/${tmp.zdjecie}" />" height="125" width="125" title="Szczegoly albumu"/></a>${tmp.nazwa}<br>   
		                    <input type="hidden" name="idprod" value="${tmp.produktid}"/>
		                    <!--<input type="hidden" name="id" id="dif_id" value="<?=$URL;?>">-->
					
		                    <c:if test="${pageContext.request.userPrincipal.name != null}"> 
			                    <input type="number" name="iloscprod" class="ilosc" title="Podaj liczbe sztuk produktu" min="1">
			                    <input type="image" data-product="${tmp.produktid}" src="<c:url value ="resources/icons/plus.png"/>" alt="Submit Form" title="Dodaj do koszyka" height="25" width="25" class="imgClass addProductBtn" >
		                    </c:if>
		                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                </div> 
	            	</form>  
				</c:forEach>
			</div>
			<div id="stopka"></div>
		</div>
		<!-- csrt for log out-->
		<c:url value="/j_spring_security_logout" var="logoutUrl" />
		<form action="${logoutUrl}" method="POST" id="logoutForm">
		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
	</body>
</html>
<script>
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
</script>
<script>
    $(document).ready(function(){
        $(".productForm").submit(function(){
            return false;
        });
        
        $(".addProductBtn").click(function(){
            addProduct(this);
        });
        
    });
    function addProduct(element){
        console.log('addProduct');
        var url = "<c:url value="/addToBasket" />";
        var prodID = $(element).data('product');
        $.ajax({
           type: "POST",
           url: url,
           data: $("#addProd"+prodID).serialize(), // serializes the form's elements.
           success: function(data)
           {
               alert(data); // show response from the php script.
           }
         });
        }
</script>