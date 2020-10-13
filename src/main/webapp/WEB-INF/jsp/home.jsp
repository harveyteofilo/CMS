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
		
		$(".deleteUser").click(function() {
			$("#confirmDelete").data("id", $(this).data("id"));
			$("#deleteModal").modal("show");
		});
		
		$("#confirmDelete").click(function() {
			$.ajax({
				url: "user/" + $(this).data("id"),
				type: "DELETE",
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
        <table class="table">
            <thead class="thead-light" align="center">
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Date of Birth</th>
                    <th>Gender</th>
                    <th>Title</th>
                    <th><a href="add-user"><button type="button" class="btn btn-primary">Add User</button></a></th>
                </tr>
            </thead>
            <tbody align="center">
                   	<c:forEach var="user" items="${users}">
	                    <tr>
	                   		<td>${user.firstName}</td>
	                   		<td>${user.lastName}</td>
	                   		<td>${user.dateOfBirth}</td>
	                   		<td>${user.gender}</td>
	                   		<td>${user.title}</td>
	                   		<td>
                   				<a href="user-detail/${user.userId}">
          							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.134 13.134 0 0 0 1.66 2.043C4.12 11.332 5.88 12.5 8 12.5c2.12 0 3.879-1.168 5.168-2.457A13.134 13.134 0 0 0 14.828 8a13.133 13.133 0 0 0-1.66-2.043C11.879 4.668 10.119 3.5 8 3.5c-2.12 0-3.879 1.168-5.168 2.457A13.133 13.133 0 0 0 1.172 8z"/>
									  <path fill-rule="evenodd" d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
									</svg>
       							</a>
                   				<a href="edit-user/${user.userId}">
          							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"></path>
									<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"></path>
									</svg>
       							</a>
						        <a class="deleteUser" href="#" data-id="${user.userId}">
						            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"></path>
									<path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"></path>
									</svg>
						        </a>
	                   		</td>
	                    </tr>
	   				</c:forEach>
            </tbody>
        </table>
    </div>
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalLabel">Delete User</h5>
					<a href="add-user">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
					</a>
				</div>
				<div class="modal-body">
					<p class="text-dark">Are you sure you want to delete this user?</p>
				</div>
				<div class="modal-footer">
					<a href="#" id="confirmDelete"><button type="button" class="btn btn-primary" data-dismiss="modal">Yes</button></a>
					<a href="#"><button type="button" class="btn btn-secondary" data-dismiss="modal">No</button></a>
				</div>
			</div>
		</div>
	</div>
    
    <div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalLabel">Delete User</h5>
					<a href="add-user">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
					</a>
				</div>
				<div class="modal-body">
				</div>
				<div class="modal-footer">
					<a href="home"><button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>