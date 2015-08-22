
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="boxed">
    <jsp:include page="includes/header.jsp" />


    <div class="inner-wrapper">
        <jsp:include page="includes/nav.jsp" />

            <section role="main" class="content-body">
                    <header class="page-header">
                            <h2>Gestion des véhicules</h2>

                            <div class="right-wrapper pull-right">
                                    <ol class="breadcrumbs">
                                            <li>
                                                    <a href="index.jsp">
                                                            <i class="fa fa-home"></i>
                                                    </a>
                                            </li>
                                            <li><span>Administration</span></li>
                                            <li><span>Véhicules</span></li>
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

                                                            <h2 class="panel-title">Liste des véhicules</h2>
                                                    </header>
                                                    <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-sm-2">
                                                                        <div class="mb-md">
                                                                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/editerVehicule">Ajouter <i class="fa fa-plus"></i></a>
                                                                        </div>
                                                                </div>
                                                            </div>
                                                            <div class="table-responsive">
                                                                    
                                                                    <table class="table table-striped mb-none">
                                                                            <thead>
                                                                                    <tr>
                                                                                            <th>#</th>
                                                                                            <th>Intitule</th>
                                                                                            <th>Matricule</th>
                                                                                            <th>Modèle</th>
                                                                                            <th>Type</th>
                                                                                            <th>Groupe</th>
                                                                                            <th>Chauffeur</th>
                                                                                            <th>Actions</th>
                                                                                    </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:forEach items="${vehicules}" var="vehicule">
                                                                                    <tr>
                                                                                            <td>${vehicule.id}</td>
                                                                                            <td>${vehicule.intitule}</td>
                                                                                            <td>${vehicule.matricule}</td>
                                                                                            <td>${vehicule.modele}</td>
                                                                                            <td>${vehicule.type}</td>
                                                                                            <td>${vehicule.groupe.nom}</td>
                                                                                            <td>${vehicule.chauffeur.nom} ${vehicule.chauffeur.prenom}</td>
                                                                                            
                                                                                            <td class="actions-hover">
                                                                                                <a href="${pageContext.request.contextPath}/editerVehicule?id=${vehicule.id}"><i class="fa fa-pencil"></i></a>
                                                                                                <a data-toggle="modal" data-target="#confirmSuppression" data-vehicule-id="${vehicule.id}" class="mb-xs mt-xs mr-xs delete-row" style="cursor:pointer;"><i class="fa fa-trash-o"></i></a>
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

    <aside id="sidebar-right" class="sidebar-right">
            <div class="nano">
                    <div class="nano-content">
                            <a href="#" class="mobile-close visible-xs">
                                    Collapse <i class="fa fa-chevron-right"></i>
                            </a>

                            <div class="sidebar-right-wrapper">

                                    <div class="sidebar-widget widget-calendar">
                                            <h6>Upcoming Tasks</h6>
                                            <div data-plugin-datepicker data-plugin-skin="dark" ></div>

                                    </div>



                            </div>
                    </div>
            </div>
    </aside>
                                                                        
                                                                        
    <div class="modal fade" id="confirmSuppression" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
                <div class="modal-content">
                        <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title" id="myModalLabel">Confirmation</h4>
                        </div>
                        <div class="modal-body">
                                 <p>Etes vous sur de vouloir supprimer ce véhicule?</p>
                        </div>
                        <div class="modal-footer">
                            <form method="post" action="${pageContext.request.contextPath}/supprimerVehicule">
                                <input type="hidden" name="id" />
                            
                                <input type="submit" class="btn btn-primary" Value="Confirmer" />
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </form>
                        </div>
                </div>
        </div>
    </div>
        
        <jsp:include page="includes/footer.jsp"/>
        <script>
        $('#confirmSuppression').on('show.bs.modal', function(e) {
            var vehicule = $(e.relatedTarget).data('vehicule-id');
            $(e.currentTarget).find('input[name="id"]').val(vehicule);
        });
        </script>
</html>
