
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
                <h2>Ajouter un chauffeur</h2>

                <div class="right-wrapper pull-right">
                    <ol class="breadcrumbs">
                        <li>
                                <a href="index.jsp">
                                        <i class="fa fa-home"></i>
                                </a>
                        </li>
                        <li><span>Chauffeurs</span></li>
                        <li><span>Ajouter</span></li>

                    </ol>

                        <a class="sidebar-right-toggle" data-open="sidebar-right"><i class="fa fa-chevron-left"></i></a>
                </div>
            </header>

                            <!-- start: page -->
                <div class="row">
                    <div class="col-lg-12">
                            <section class="panel">
                                
                               
                                <form:form class="form-horizontal form-bordered" method="post" action="${pageContext.request.contextPath}/ajouterChauffeur" commandName="chauffeur">    
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

                                            <h2 class="panel-title">Ajouter un chauffeur</h2>
                                    </header>
                                    <div class="panel-body">
                                            <c:if test="${(not empty chauffeur) && chauffeur.id!=0}">
                                                <input type="hidden" name="id" value="${chauffeur.id}"/>
                                            </c:if>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Nom</label>
                                                <div class="col-md-6">
                                                        <input type="text" name="nom" class="form-control" value="${chauffeur.nom}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Prenom</label>
                                                <div class="col-md-6">
                                                        <input type="text" name="prenom" class="form-control" value="${chauffeur.prenom}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label" >E-mail</label>
                                                <div class="col-md-6">
                                                        <input type="text" name="email" class="form-control"  value="${chauffeur.email}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Téléphone</label>
                                                <div class="col-md-6">
                                                        <input type="text" name="tel" class="form-control" value="${chauffeur.tel}">
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
