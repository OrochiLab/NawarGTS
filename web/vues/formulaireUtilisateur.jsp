
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!doctype html>
<html class="boxed">
    <jsp:include page="includes/header.jsp" />


<div class="inner-wrapper">
    <jsp:include page="includes/nav.jsp" >
            <jsp:param name="bloc" value="administration" />
        </jsp:include>
        <section role="main" class="content-body">
            <header class="page-header">
                <h2>Editer un utilisateur</h2>

                <div class="right-wrapper pull-right">
                    <ol class="breadcrumbs">
                        <li>
                                <a href="index.jsp">
                                        <i class="fa fa-home"></i>
                                </a>
                        </li>
                        <li><span>Utilisateurs</span></li>
                        <li><span>Editer</span></li>

                    </ol>

                        <a class="sidebar-right-toggle" data-open="sidebar-right"><i class="fa fa-chevron-left"></i></a>
                </div>
            </header>

                            <!-- start: page -->
                <div class="row">
                    <div class="col-lg-12">
                            <section id="w1" class="panel">
                                
                               
                                <form:form class="form-horizontal form-bordered" method="post" action="${pageContext.request.contextPath}/ajouterUtilisateur" commandName="utilisateur">    
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

                                            <h2 class="panel-title">Editer un utilisateur</h2>
                                    </header>
                                    <div class="panel-body">
                                            <div class="wizard-tabs">
                                                <ul class="wizard-steps">
                                                    <li class="active">
                                                        <a href="#w-utilisateur" data-toggle="tab" class="text-center">
                                                            <span class="badge hidden-xs">1</span>
                                                            Utilisateur
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="#w-permissions" data-toggle="tab" class="text-center">
                                                            <span class="badge hidden-xs">2</span>
                                                            Permissions
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="#w-confirmation" data-toggle="tab" class="text-center">
                                                            <span class="badge hidden-xs">3</span>
                                                            Confirmation
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="tab-content">
                                                <div id="w-utilisateur" class="tab-pane active">
                                                    <c:if test="${(not empty utilisateur) && utilisateur.id!=0}">
                                                        <input type="hidden" name="id" value="${utilisateur.id}"/>
                                                    </c:if>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">Nom</label>
                                                        <div class="col-md-6">
                                                                <input type="text" name="nom" class="form-control" value="${utilisateur.nom}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">Prenom</label>
                                                        <div class="col-md-6">
                                                                <input type="text" name="prenom" class="form-control" value="${utilisateur.prenom}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label" >E-mail</label>
                                                        <div class="col-md-6">
                                                            <div class="input-group btn-group">
                                                                <span class="input-group-addon">
                                                                        <i class="fa fa-envelope"></i>
                                                                </span>
                                                                <input type="text" name="email" class="form-control"  value="${utilisateur.email}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">Téléphone</label>
                                                        <div class="col-md-6">
                                                            <div class="input-group btn-group">
                                                                <span class="input-group-addon">
                                                                        <i class="fa fa-phone"></i>
                                                                </span>
                                                                <input type="text" name="tel" class="form-control" value="${utilisateur.tel}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label" >Compte</label>
                                                        <div class="col-md-6">
                                                            <div class="input-group btn-group">
                                                                <span class="input-group-addon">
                                                                        <i class="fa fa-user"></i>
                                                                </span>
                                                                <input type="text" name="compte" class="form-control" value="${utilisateur.compte}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label" >Mot de passe</label>
                                                        <div class="col-md-6">
                                                            <div class="input-group btn-group">
                                                                <span class="input-group-addon">
                                                                        <i class="fa fa-key"></i>
                                                                </span>
                                                                <input type="password" name="password" class="form-control" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                        
                                                <div id="w-permissions" class="tab-pane">
                                                    <c:forEach items="${categories}" var="categorie">
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label" >${categorie.intitule} : </label>
                                                        <div class="col-md-6">
                                                            <c:forEach items="${categorie.permissions}" var="permission">
                                                                <div class="checkbox-custom checkbox-primary">
                                                                    <input name="perm[]" type="checkbox" id="perm${permission.id}" value="${permission.id}" 
                                                                           ${(map[permission.intitule]!=null)?"checked='checked'":""}/>
                                                                    <label for="perm${permission.id}">${permission.description}</label>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    </c:forEach>    
                                                </div>
                                                            
                                                <div id="w-confirmation" class="tab-pane">
                                                    <input type="submit" class="btn btn-primary" value="Valider"/>
                                                </div>
                                            </div>
                                    </div>
                                    <div class="panel-footer">
                                        <ul class="pager">
                                            <li class="previous">
                                                    <a><i class="fa fa-angle-left"></i> Précedent</a>
                                            </li>
                                            <li class="finish hidden pull-right">
                                                    <a>Valider</a>
                                            </li>
                                            <li class="next">
                                                    <a>suivant <i class="fa fa-angle-right"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                </form:form>
                            </section>
                    </div>
                </div>
                <!-- end: page -->
        </section>
</div>
    
    <jsp:include page="includes/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/vues/assets/vendor/bootstrap-wizard/jquery.bootstrap.wizard.js"></script>
    
    <script>
        $('#w1').bootstrapWizard({
		tabClass: 'wizard-steps',
		nextSelector: 'ul.pager li.next',
		previousSelector: 'ul.pager li.previous',
		firstSelector: null,
		lastSelector: null,
		onNext: function( tab, navigation, index, newindex ) {
			/*var validated = $('#w1 form').valid();
			if( !validated ) {
				$w1validator.focusInvalid();
				return false;
			}*/
                    return true;
		},
		onTabClick: function( tab, navigation, index, newindex ) {
			if ( newindex == index + 1 ) {
				return this.onNext( tab, navigation, index, newindex);
			} else if ( newindex > index + 1 ) {
				return false;
			} else {
				return true;
			}
		},
		onTabChange: function( tab, navigation, index, newindex ) {
			var totalTabs = navigation.find('li').size() - 1;
			//$w1finish[ newindex != totalTabs ? 'addClass' : 'removeClass' ]( 'hidden' );
			$('#w1').find(this.nextSelector)[ newindex == totalTabs ? 'addClass' : 'removeClass' ]( 'hidden' );
		}
	});
        
    </script>
</html>
