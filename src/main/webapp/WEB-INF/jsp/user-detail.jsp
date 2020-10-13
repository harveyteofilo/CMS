<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Detail</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="/cms/home">Home</a>
				</li>
			</ul>
		</div>
	</nav>
    <div class="container" style="margin-top: 50px">
    
	    <div class="row">
		    <div class="col-3">First Name</div>
		    <div class="col-9"><strong>${user.firstName}</strong></div>
	  	</div>
	  	
	    <div class="row">
		    <div class="col-3">Last Name</div>
		    <div class="col-9"><strong>${user.lastName}</strong></div>
	  	</div>
	  	
	    <div class="row">
		    <div class="col-3">Date of Birth</div>
		    <div class="col-9"><strong>${user.dateOfBirth}</strong></div>
	  	</div>
	  	
	    <div class="row">
		    <div class="col-3">Gender</div>
		    <div class="col-9"><strong>${user.gender}</strong></div>
	  	</div>
	  	
	    <div class="row">
		    <div class="col-3">Title</div>
		    <div class="col-9"><strong>${user.title}</strong></div>
	  	</div>
	  	
	    <div class="row">
		    <div class="col-3">Address List</div>
	  	</div>
	  	<table class="table" style="margin-top: 10px">
		    <thead class="thead-light">
		        <tr>
			        <th>Type</th>
			        <th>Number</th>
			        <th>Street</th>
			        <th>Unit</th>
			        <th>City</th>
			        <th>State</th>
			        <th>Zipcode</th>
		    	</tr>
	    	</thead>
            <tbody>
               	<c:forEach var="address" items="${user.addressList}">
	            <tr>
	            	<td>${address.type}</td>
	            	<td>${address.number}</td>
	            	<td>${address.street}</td>
	            	<td>${address.unit}</td>
	            	<td>${address.city.name}</td>
	            	<td>${address.city.stateName}</td>
	            	<td>${address.zipCode}</td>
           		</tr>
               	</c:forEach>
            </tbody>
        </table>
        
	    <div class="row">
		    <div class="col-3">Contact List</div>
	  	</div>
	  	<table class="table" style="margin-top: 10px">
		    <thead class="thead-light">
		        <tr>
			        <th>Type</th>
			        <th>Value</th>
			        <th>Preferred</th>
		    	</tr>
	    	</thead>
            <tbody>
               	<c:forEach var="contact" items="${user.contactList}">
	            <tr>
	            	<td>${contact.type}</td>
	            	<td>${contact.value}</td>
	            	<td>${contact.isPreferred}</td>
           		</tr>
               	</c:forEach>
            </tbody>
        </table>
        
    </div>
</body>
</html>