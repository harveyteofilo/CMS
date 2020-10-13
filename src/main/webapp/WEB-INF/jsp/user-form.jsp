<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${pageTitle}</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
	<script>
	$(function() {
		// POPULATE CITY OPTIONS AFTER SELECTING STATE
		$("#stateSelect").change(function() {
			if ("" != $(this).val()) {
				var stateId = $(this).find("option:selected").val();
				// GET CITIES OF SELECTED STATE
				$.get("/cms/state/" + stateId + "/cities", function(data) {
					$("#citySelect").empty();
					$("#citySelect").append($("<option>", {
					    value: "",
					    text: "Please Select"
					}));
					$.each(data, function(index, city) {
						$("#citySelect").append($("<option>", {
						    value: city.cityId,
						    text: city.name,
						    "data-name": "cityId"
						}));
					});
				});
				$("#citySelect").attr("disabled", false);
			} else {
				$("#citySelect").empty();
				$("#citySelect").append($("<option>", {
				    value: "",
				    text: "Please Select"
				}));
				$("#citySelect").attr("disabled", true);
			}
		});
		
		$("#addAddress").click(function() {
			// VALIDATE INPUT ELEMENTS
			var isValid = true;
			var $addressTableRow = $("#addAddress").parent("td").parent("tr");
			var $columns = $addressTableRow.find("td");
			var addressInfo = {};
			$columns.each(function(index, column) {
				var inputVal = null;
				var inputElement = null;
				if (0 != $(column).find("input").length) {
					inputElement = $(column).find("input");
					inputVal = $(column).find("input").val();
				} else if (0 != $(column).find("select").length) {
					inputElement = $(column).find("select");
					inputVal = $(column).find("select").find("option:selected").val();
				}
				if ("" == inputVal) {
					$(inputElement).addClass("is-invalid");
					isValid = false;
				} else {
					$(inputElement).removeClass("is-invalid");
					if (null != inputVal) {
						if ($(inputElement).is("select")) {
							var selectData = {};
							selectData["id"] = $(inputElement).find("option:selected").data("name");
							selectData["value"] = $(inputElement).find("option:selected").val();
							selectData["text"] = $(inputElement).find("option:selected").text();
							addressInfo[$(inputElement).data("name")] = selectData;
						} else {
							addressInfo[$(inputElement).data("name")] = inputVal;
						}
					}
				}
			});
			if (isValid) {
				// ADD ADDRESS INFO TO TABLE
				$newAddressRow = $("<tr>");
				$.each(Object.keys(addressInfo), function(index, key) {
					$newAddressColumn = $("<td>");
					if (typeof(addressInfo[key]) === "object") {
						// ADD HIDDEN COLUMN TO HOLD ID
						$idColumn = $("<td>");
						$idColumn.data("name", addressInfo[key].id);
						$idColumn.append(addressInfo[key].value);
						$idColumn.prop("hidden", true);
						$newAddressRow.append($idColumn);
						$newAddressColumn.append(addressInfo[key].text);
					} else {
						$newAddressColumn.append(addressInfo[key]);
					}
					$newAddressColumn.data("name", key);
					$newAddressRow.append($newAddressColumn);
				});
				// ADD DELETE BUTTON
				$newAddressRow.append($("<td>").append('<a id="deleteAddress" href="#"><button type="button" class="btn btn-outline-danger">Delete</button></a>'));
				$("#addressTable").find("tr:last").before($newAddressRow);
				// RESET INPUTS TO ADD ADDRESS INFO
				$(this).closest("tr").find("input[type=text]").val("");
				$(this).closest("tr").find("#stateSelect").val("").change();
			}
		});
		
		$(document.body).on("click", "#deleteAddress", function() {
			$(this).closest("tr").remove();
		});
		
		
		$("#addContact").click(function() {
			// VALIDATE INPUT ELEMENTS
			var isValid = true;
			var $columns = $("#addContact").parent("td").parent("tr").find("td");
			var contactInfo = {};
			$columns.each(function(index, column) {
				var inputVal = null;
				var inputElement = null;
				if (0 != $(column).find("input").length) {
					inputElement = $(column).find("input");
					inputVal = $(column).find("input").val();
				}
				if ("" == inputVal) {
					$(inputElement).addClass("is-invalid");
					isValid = false;
				} else {
					$(inputElement).removeClass("is-invalid");
					if (null != inputVal) {
						// VALUE FOR IS PREFERRED
						if ($(inputElement).attr("type") == "checkbox") {
							inputVal = $(inputElement).prop("checked") ? "Yes" : "No";
						}
						contactInfo[$(inputElement).data("name")] = inputVal;
					}
				}
			});
			if (isValid) {
				// ADD CONTACT INFO TO TABLE
				$newContactRow = $("<tr>");
				$.each(Object.keys(contactInfo), function(index, key) {
					$newContactColumn = $("<td>");
					$newContactColumn.append(contactInfo[key]);
					$newContactColumn.data("name", key);
					$newContactRow.append($newContactColumn);
				});
				// ADD DELETE BUTTON
				$newContactRow.append($("<td>").append('<a id="deleteContact" href="#"><button type="button" class="btn btn-outline-danger">Delete</button></a>'));
				$("#contactTable").find("tr:last").before($newContactRow);
				// RESET INPUTS TO ADD CONTACT INFO
				$(this).closest("tr").find("input[type=text]").val("");
				$("#isPreferred").prop("checked", false);
			}
		});
		
		$(document.body).on("click", "#deleteContact", function() {
			$(this).closest("tr").remove();
		});
		
		$("#submitForm").click(function() {
			// VALIDATE INPUT FIELDS
			var isValid = true;
			var inputIDs = ["firstName", "lastName", "dateOfBirth", "gender", "title"];
			$.each(inputIDs, function(index, id) {
				if ("" == $("#" + id).val()) {
					$("#" + id).addClass("is-invalid");
					isValid = false;
				} else {
					$("#" + id).removeClass("is-invalid");
				}
			});
			// SUBMIT FORM
			if (isValid) {
				var userData = $("#userForm").serializeArray().reduce(function(obj, item) {
				    obj[item.name] = item.value;
				    return obj;
				}, {});
				// SET USER ADDRESSES
				var $addressRows = $("#addressTable").find("tbody tr");
				if ($addressRows.length > 1) {
					var addressDataList = [];
					$.each($addressRows, function(index, addressRow) {
						// EXCLUDE LAST ROW
						if (index < ($addressRows.length - 1)) {
							var addressData = {};
							var $addressColumns = $(addressRow).find("td");
							$.each($addressColumns, function(index, addressColumn) {
								// EXCLUDE DELETE BUTTON COLUMN
								if ($(addressColumn).children().length == 0) {
									addressData[$(addressColumn).data("name")] = $(addressColumn).text();
								}
							});
							addressDataList.push(addressData);
						}
					});
					userData["addressList"] = addressDataList;
				}
				// SET USER CONTACTS
				var $contactRows = $("#contactTable").find("tbody tr");
				if ($contactRows.length > 1) {
					var contactDataList = [];
					$.each($contactRows, function(index, contactRow) {
						// EXCLUDE LAST ROW
						if (index < ($contactRows.length - 1)) {
							var contactData = {};
							var $contactColumns = $(contactRow).find("td");
							$.each($contactColumns, function(index, contactColumn) {
								// EXCLUDE DELETE BUTTON COLUMN
								if ($(contactColumn).children().length == 0) {
									contactData[$(contactColumn).data("name")] = $(contactColumn).text();
								}
							});
							contactDataList.push(contactData);
						}
					});
					userData["contactList"] = contactDataList;
				}
				// SAVE USER
				var method = $(this).data("method");
				var url = $(this).data("url");
				$.ajax({
					url: url,
					type: method,
					data: JSON.stringify(userData),
		            contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function(data) {
						if (null != data && 200 == data.status) {
							$("#resultModal").find(".modal-body").html("<p class='text-success'>" + data.msg + "</p>");
						} else {
							$("#resultModal").find(".modal-body").html("<p class='text-danger'>" + data.msg + "</p>");
						}
						$("#resultModal").modal("show");
					}
				});
			}
		});

		$(document).on("hide.bs.modal", "#resultModal", function() {
			location.reload();
		});
	});
	</script>
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
    
    	<form id="userForm">
			<input type="hidden" class="form-control" id="userId" name="userId" value="${user.userId}">
			<div class="form-group row">
			    <label for="firstName" class="col-sm-2 col-form-label">First Name</label>
			    <div class="col-sm-5">
					<input type="text" class="form-control" id="firstName" name="firstName" value="${user.firstName}">
			    </div>
			</div>
			<div class="form-group row">
			    <label for="lastName" class="col-sm-2 col-form-label">Last Name</label>
			    <div class="col-sm-5">
					<input type="text" class="form-control" id="lastName" name="lastName" value="${user.lastName}">
			    </div>
			</div>
			<div class="form-group row">
			    <label for="dateOfBirth" class="col-sm-2 col-form-label">Date Of Birth</label>
			    <div class="col-sm-5">
					<input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${user.dateOfBirth}">
			    </div>
			</div>
			<div class="form-group row">
			    <label for="gender" class="col-sm-2 col-form-label">Gender</label>
			    <div class="col-sm-5">
					<select class="form-control" id="gender" name="gender">
						<option value="">Please Select</option>
						<c:choose>
						    <c:when test="${user.gender == 'Male'}">
								<option value="Male" selected>Male</option>
								<option value="Female">Female</option>
						    </c:when>
						    <c:when test="${user.gender == 'Female'}">
								<option value="Male">Male</option>
								<option value="Female" selected>Female</option>
						    </c:when>
						    <c:otherwise>
								<option value="Male">Male</option>
								<option value="Female">Female</option>
						    </c:otherwise>
						</c:choose>
					</select>
			    </div>
			</div>
			<div class="form-group row">
			    <label for="title" class="col-sm-2 col-form-label">Title</label>
			    <div class="col-sm-5">
					<input type="text" class="form-control" id="title" name="title" value="${user.title}">
			    </div>
			</div>
	  	
		    <div class="form-group row">
			    <div class="col-3">Address List</div>
		  	</div>
		  	<table id="addressTable" class="table" style="margin-top: 10px">
			    <thead class="thead-light">
			        <tr>
				        <th>Type</th>
				        <th>Number</th>
				        <th>Street</th>
				        <th>Unit</th>
				        <th>City</th>
				        <th>State</th>
				        <th>Zipcode</th>
				        <th></th>
			    	</tr>
		    	</thead>
	            <tbody>
	               	<c:forEach var="address" items="${user.addressList}">
		            <tr>
		            	<td data-name="addressId" hidden>${address.addressId}</td>
		            	<td data-name="type">${address.type}</td>
		            	<td data-name="number">${address.number}</td>
		            	<td data-name="street">${address.street}</td>
		            	<td data-name="unit">${address.unit}</td>
		            	<td data-name="cityId" hidden>${address.city.cityId}</td>
		            	<td data-name="city.name">${address.city.name}</td>
		            	<td>${address.city.stateName}</td>
		            	<td data-name="zipCode">${address.zipCode}</td>
		            	<td>
		            		<a id="deleteAddress" href="#">
		            			<button type="button" class="btn btn-outline-danger">Delete</button>
		            		</a>
		            	</td>
	           		</tr>
	               	</c:forEach>
	               	<tr>
		            	<td><input type="text" id="addressType" data-name="type" class="form-control"/></td>
		            	<td><input type="text" id="number" data-name="number" class="form-control"/></td>
		            	<td><input type="text" id="street" data-name="street" class="form-control"/></td>
		            	<td><input type="text" id="unit" data-name="unit" class="form-control"/></td>
		            	<td>
		            		<select id="citySelect" data-name="city.name" class="form-control" disabled>
               					<option value="">Please Select</option>
		            		</select>
	            		</td>
		            	<td>
		            		<select id="stateSelect" data-name="city.stateName" class="form-control">
               					<option value="">Please Select</option>
	               				<c:forEach var="state" items="${states}">
	               					<option value="${state.stateId}">${state.name}</option>
	               				</c:forEach>
		            		</select>
		            	</td>
		            	<td><input type="text" id="zipCode" data-name="zipCode" class="form-control"/></td>
		            	<td>
                			<a id="addAddress" href="#">
								<button type="button" class="btn btn-outline-primary">Add</button>
                			</a>
		            	</td>
		            </tr>
	            </tbody>
	        </table>
	        
		    <div class="row">
			    <div class="col-3">Contact List</div>
		  	</div>
		  	<table id="contactTable" class="table" style="margin-top: 10px">
			    <thead class="thead-light">
			        <tr>
				        <th>Type</th>
				        <th>Value</th>
				        <th>Is Preferred</th>
				        <th></th>
			    	</tr>
		    	</thead>
	            <tbody>
	               	<c:forEach var="contact" items="${user.contactList}">
		            <tr>
		            	<td data-name="contactId" hidden>${contact.contactId}</td>
		            	<td data-name="type">${contact.type}</td>
		            	<td data-name="value">${contact.value}</td>
		            	<td data-name="isPreferred">${contact.isPreferred}</td>
		            	<td>
		            		<a id="deleteContact" href="#">
		            			<button type="button" class="btn btn-outline-danger">Delete</button>
		            		</a>
		            	</td>
	           		</tr>
	               	</c:forEach>
	               	<tr>
		            	<td><input type="text" data-name="type" class="form-control"/></td>
		            	<td><input type="text" data-name="value" class="form-control"/></td>
		            	<td>
		            		<div class="custom-control custom-switch">
								<input type="checkbox" class="custom-control-input" id="isPreferred" data-name="isPreferred">
								<label class="custom-control-label" for="isPreferred">Preferred</label>
							</div>
						</td>
		            	<td>
                			<a id="addContact" href="#">
								<button type="button" class="btn btn-outline-primary">Add</button>
                			</a>
		            	</td>
	            </tbody>
	        </table>
	        
	        <div class="row">
          		<a id="submitForm" data-method="${method}" data-url="${url}" href="#">
          			<button type="button" class="btn btn-primary">Submit</button>
          		</a>
	        </div>
		</form>
    
    </div>
    
    <div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalLabel">${pageTitle}</h5>
					<a href="/cms/add-user">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
					</a>
				</div>
				<div class="modal-body">
				</div>
				<div class="modal-footer">
					<a href="/cms/add-user"><button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button></a>
					<a href="/cms/home"><button type="button" class="btn btn-primary">View Users</button></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
