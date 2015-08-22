
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!doctype html>
<html class="boxed">
    <jsp:include page="includes/header.jsp" />


<div class="inner-wrapper">
    <jsp:include page="includes/nav.jsp" />

        <section role="main" class="content-body">
            <header class="page-header">
                <h2>Ajouter un véhicule</h2>

                <div class="right-wrapper pull-right">
                    <ol class="breadcrumbs">
                        <li>
                                <a href="index.jsp">
                                        <i class="fa fa-home"></i>
                                </a>
                        </li>
                        <li><span>Vehicules</span></li>
                        <li><span>Ajouter</span></li>

                    </ol>

                        <a class="sidebar-right-toggle" data-open="sidebar-right"><i class="fa fa-chevron-left"></i></a>
                </div>
            </header>

                <!-- start: page -->
                <div class="row">
                    <div class="col-lg-12">
                            <section class="panel">
                                
                               
                                <form:form class="form-horizontal form-bordered" method="post" action="${pageContext.request.contextPath}/ajouterVehicule" commandName="vehicule">    
                                    <c:if test="${not empty erreur}">
                                        <div class="alert alert-danger">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                            <strong><form:errors path="*" /></strong>
                                        </div>
                                    </c:if>
                                    
                                    <header class="panel-heading">
                                            <div class="panel-actions">
                                                    <a href="#" class="fa fa-caret-down"></a>

                                            </div>

                                            <h2 class="panel-title">Ajouter un véhicule</h2>
                                    </header>
                                    <div class="panel-body">
                                            <c:if test="${(not empty vehicule) && vehicule.id!=0}">
                                                <input type="hidden" name="id" value="${vehicule.id}"/>
                                            </c:if>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Intitulé</label>
                                                <div class="col-md-6">
                                                        <input type="text" name="intitule" class="form-control" value="${vehicule.intitule}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Matricule</label>
                                                <div class="col-md-6">
                                                        <input type="text" name="matricule" class="form-control" value="${vehicule.matricule}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label" >Modèle</label>
                                                <div class="col-md-6">
                                                        <input type="text" name="modele" class="form-control"  value="${vehicule.modele}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Type</label>
                                                <div class="col-md-6">
                                                        <input type="text" name="type" class="form-control" value="${vehicule.type}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label" >Chauffeur</label>
                                                <div class="col-md-6">
                                                    <div class="input-group btn-group">
                                                        <span class="input-group-addon">
                                                                <i class="fa fa-user"></i>
                                                        </span>
                                                        <select class="form-control" name="chauffeur_id">
                                                            <c:forEach items="${chauffeurs}" var="chauffeur">
                                                                <option value="${chauffeur.id}"><c:out value="${chauffeur.nom} ${chauffeur.prenom}" /></option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label" >Groupe</label>
                                                <div class="col-md-6">
                                                    <div class="input-group btn-group">
                                                        <span class="input-group-addon">
                                                                <i class="fa fa-folder-open"></i>
                                                        </span>
                                                        <select class="form-control" name="groupe_id">
                                                            <c:forEach items="${groupes}" var="groupe">
                                                                <option value="${groupe.id}"><c:out value="${groupe.nom}" /></option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label" for="inputDefault">Vehicule</label>
                                                <div class="col-md-6">
                                                        <div class="radio-custom radio-success">
                                                            <input type="radio" id="active_radio" name="active" value="true" checked="checked">
                                                            <label for="active_radio">Active</label>
                                                        </div>
                                                        <div class="radio-custom radio-warning">
                                                            <input type="radio" id="inactive_radio" name="active" value="false">
                                                            <label for="inactive_radio">Inactive</label>
                                                        </div>

                                                </div>
                                            </div>

                                    </div>
                                    <footer class="panel-footer">
                                        <div class="row">
                                            <div class="col-sm-12 col-sm-offset-3">
                                                    <button class="btn btn-primary">Valider</button>
                                                    <button type="reset" class="btn btn-default">Vider</button>
                                            </div>
                                        </div>
                                    </footer>
                                </form:form>
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
    <jsp:include page="includes/footer.jsp"/>
</html>
