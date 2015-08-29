<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="boxed">
    <jsp:include page="includes/header.jsp" />


    <div class="inner-wrapper">
        <jsp:include page="includes/nav.jsp" >
            <jsp:param name="bloc" value="administration" />
        </jsp:include>

            <section role="main" class="content-body">
                    <header class="page-header">
                        <h2>Gestion des utilisateurs & permissions</h2>

                            <div class="right-wrapper pull-right">
                                    <ol class="breadcrumbs">
                                            <li>
                                                    <a href="index.jsp">
                                                            <i class="fa fa-home"></i>
                                                    </a>
                                            </li>
                                            <li><span>Administration</span></li>
                                            <li><span>Utilisateurs</span></li>
                                            
                                    </ol>

                                    <a class="sidebar-right-toggle" data-open="sidebar-right"><i class="fa fa-chevron-left"></i></a>
                            </div>
                    </header>
                
                <!-- start: page -->
                    <div class="row">
                                    <div class="col-lg-12">
                                            <section class="panel">
                                                
                                                <c:if test="${not empty message}">
                                                    <div class="alert alert-success">
                                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                                        <strong><c:out value="${message}"/></strong>
                                                    </div>
                                                </c:if>
                                                 <header class="panel-heading">
                                                            <div class="panel-actions">
                                                                    <a href="#" class="fa fa-caret-down"></a>
                                                            </div>

                                                            <h2 class="panel-title">Liste des Utilisateurs</h2>
                                                    </header>
                                                    <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-sm-2">
                                                                        <div class="mb-md">
                                                                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/editerUtilisateur">Ajouter <i class="fa fa-plus"></i></a>
                                                                        </div>
                                                                </div>
                                                            </div>
                                                            <div class="table-responsive">
                                                                 <table class="table table-striped mb-none">
                                                                            <thead>
                                                                                    <tr>
                                                                                            <th>Compte</th>
                                                                                            <th>Nom</th>
                                                                                            <th>Prenom</th>
                                                                                            <th>Télephone</th>
                                                                                            <th>E-mail</th>
                                                                                            <th>Actions</th>
                                                                                    </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                 <c:forEach items="${utilisateurs}" var="utilisateur">
                                                                                    <tr>
                                                                                            <td>${utilisateur.compte}</td>
                                                                                            <td>${utilisateur.nom}</td>
                                                                                            <td>${utilisateur.prenom}</td>
                                                                                            <td>${utilisateur.tel}</td>
                                                                                            <td>${utilisateur.email}</td>
                                                                                            <td class="actions-hover">
                                                                                                <a href="${pageContext.request.contextPath}/editerUtilisateur?id=${utilisateur.id}"><i class="fa fa-pencil"></i></a>
                                                                                                <a data-toggle="modal" data-target="#confirmSuppression" data-utilisateur-id="${utilisateur.id}" class="mb-xs mt-xs mr-xs delete-row" style="cursor:pointer;"><i class="fa fa-trash-o"></i></a>
                                                                                            </td>
                                                                                            
                                                                                    </tr>
                                                                                </c:forEach>
                                                                            </tbody>
                                                                    </table>
                                                                 </div>
                                                        </div>
                                            </section>
                                    </div>
                    </div>
                    <!-- end: page -->
            </section>
    </div>

                                                                        
    <div class="modal fade" id="confirmSuppression" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
                <div class="modal-content">
                        <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title" id="myModalLabel">Confirmation</h4>
                        </div>
                        <div class="modal-body">
                                 <p>Etes vous sur de vouloir supprimer cet utilisateur?</p>
                        </div>
                        <div class="modal-footer">
                            <form method="post" action="${pageContext.request.contextPath}/supprimerUtilisateur">
                                <input type="text" name="id" />
                            
                                <input type="submit" class="btn btn-primary" Value="Confirmer" />
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </form>
                        </div>
                </div>
        </div>
    </div>        <jsp:include page="includes/footer.jsp"/>
        <script>
        $('#confirmSuppression').on('show.bs.modal', function(e) {
            var utilisateur = $(e.relatedTarget).data('utilisateur-id');
            $(e.currentTarget).find('input[name="id"]').val(utilisateur);
        });
        </script>
</html>