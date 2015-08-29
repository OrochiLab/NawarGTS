
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="boxed">
    <jsp:include page="includes/header.jsp" />
    <style>
        .iconne_map{
            cursor:pointer;
            opacity:0.8;
        }
        .iconne_map:hover{
            opacity:1;
        }
        .selected_iconne_map{
            opacity:1;
            padding-bottom:10px;
        }
        .list-markers .location-action.location-show-hide {
            right: 53px;
            top: 3px;
        }
        
    </style>

			<div class="inner-wrapper">
                            <jsp:include page="includes/nav.jsp" >
                                <jsp:param name="bloc" value="administration" />
                            </jsp:include>
				<section role="main" class="content-body">
					<header class="page-header">
						<h2>Points d'interet</h2>
					
						
					</header>
                                        
                                        
                                        					<!-- start: page -->
					<section class="content-with-menu" data-theme-gmap-builder>
						<div class="content-with-menu-container">

							<div class="inner-menu-toggle">
								<a href="#" class="inner-menu-expand" data-open="inner-menu">
									Afficher options <i class="fa fa-chevron-right"></i>
								</a>
							</div>

							<menu id="content-menu" class="inner-menu" role="menu">
								<div class="nano">
									<div class="nano-content">

										<div class="inner-menu-toggle-inside">
											<a href="#" class="inner-menu-collapse">
												<i class="fa fa-chevron-up visible-xs-inline"></i><i class="fa fa-chevron-left hidden-xs-inline"></i>Cacher
											</a>
											<a href="#" class="inner-menu-expand" data-open="inner-menu">
												Afficher options <i class="fa fa-chevron-down"></i>
											</a>
										</div>

										<div class="inner-menu-content">

											
											<p class="title">Points d'interêts</p>

											<div class="form-group">
												<ul id="MarkersList" class="list-markers list-unstyled mb-lg">
                                                                                                    <!-- Remplissage par DOM javascript -->
												</ul>

												<div class="row">
													<div class="col-sm-12">
														<button id="btn_valider" class="btn btn-primary btn-block mb-lg" type="button" data-toggle="modal" data-target="#MarkerModal">Enregistrer les changements</button>
													</div>
													
												</div>
											</div>
										</div>
									</div>
								</div>
							</menu>
							<div class="inner-body">
								<div id="map" style="height:500px;"></div>
							</div>
					</section>
                                        
                                    
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
                             <p>Etes vous sur de vouloir supprimer ce point?</p>
                    </div>
                    <div class="modal-footer">
                        
                            <input type="hidden" id="modal_supp_id" />

                            <input type="submit" class="btn btn-primary" id="modal_btn_supp" data-dismiss="modal" Value="Confirmer" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
                        
                    </div>
            </div>
    </div>
</div>                            
                                            
<div class="modal fade" id="formulairePoint" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
            <div class="modal-content">
                    <div class="modal-header">
                            <!--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>-->
                            <h4 class="modal-title" id="myModalLabel">Point d'interet</h4>
                    </div>
                    <form method="post" action="#" id="modal_form">
                        <div class="modal-body">
                                 <div class="form-group">
                                    <input type="hidden" name="id" id="modal_form_id"/>
                                    <input type="hidden" id="modal_marker_id"/>
                                    
                                    <label class="col-md-3 control-label">Nom :</label>
                                    <div class="col-md-6">
                                            <input type="text" name="nom" id="modal_form_nom" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Adresse :</label>
                                    <div class="col-md-6">
                                            <input type="text" name="adresse" id="modal_form_adresse" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Description :</label>
                                    <div class="col-md-6">
                                        <textarea type="text" name="description" id="modal_form_description" class="form-control"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">Iconne :</label>
                                    <div class="col-md-6">
                                        <input type="hidden" id="modal_form_icone" value="computers.png"/>
                                        <c:forEach items="${iconnes}" var="icone" varStatus="index">
                                            <c:choose>
                                            <c:when test="${index.count==1}">
                                                <img class="iconne_map selected_iconne_map" data-icone-name="${icone}" src="${pageContext.request.contextPath}/vues/assets/icons/points/${icone}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img class="iconne_map" data-icone-name="${icone}" src="${pageContext.request.contextPath}/vues/assets/icons/points/${icone}"/>
                                            </c:otherwise>
                                            </c:choose>
                                        </c:forEach>         
                                        
                                    </div>
                                </div>
                        </div>
                        <div class="modal-footer">
                                <button id="modal_btn_valider" type="button" class="btn btn-primary" data-dismiss="modal">Valider</button>
                                <button type="button" id="modal_btn_annuler" class="btn btn-default" data-dismiss="modal">Annuler</button>

                        </div>
                    </form>
            </div>
    </div>
</div>

                            <jsp:include page="includes/footer.jsp"/>
<script>
       var points;
       var markers = [];
       var map;
        $(document).ready(function(){
  
                map = new GMaps({
			div: '#map',
			lat: -12.043333,
			lng: -77.028333
		});
                
                $.ajax({
                  method: "GET",
                  url: "${pageContext.request.contextPath}/json/points"
                }).done(function( e ) {
                    points=e;
            
                    for(var i=0;i<points.length;i++)
                    {
                        var marker = {
                            lat : points[i].latitude,
                            lng : points[i].longitude,
                            draggable : true,
                            title : points[i].nom,
                            infoWindow:{
                               //content : '<h5><strong>Nom : </strong>'+points[i].nom+'</h5><p><strong>Adresse : </strong>'+points[i].adresse+'<br/><strong>Description : </strong>'+points[i].description+'</p>'
                               content : content(points[i].nom,points[i].adresse,points[i].description,points[i].icone)
                            },
                            icon:'${pageContext.request.contextPath}/vues/assets/icons/points/'+points[i].icone
                        };
                        markers.push(map.addMarker(marker));
                        markers[markers.length-1].point_interet={
                            'id':points[i].id,
                            'nom':points[i].nom,
                            'adresse':points[i].adresse,
                            'description':points[i].description,
                            'icone':points[i].icone};
                        
                        ajouter_point_menu(points[i].nom,(markers.length)-1);
                     
                    }
                  });
                
                map.setContextMenu({
                        control: 'map',
                        options: [{
                            title: 'Ajouter un point',
                            name: 'ajouter_point',
                            action: function(e) {
                                //alert("Choix menu ajout point !");
                                $("#formulairePoint").modal("show"); // j'affiche la fenetre modale
                                $("#modal_form_id").val("0"); // je met l'input id a 0
                                $("#modal_marker_id").val("-1");
                                $("#modal_form_nom").val("");
                                $("#modal_form_adresse").val("");
                                $("#modal_form_description").val("");
                                $("#modal_form_icone").val("regroup.png");
                                $(".iconne_map").removeClass("selected_iconne_map");
                                $(".iconne_map[data-icone-name='regroup.png']").addClass("selected_iconne_map");
                                var marker = {
                                    lat : e.latLng.lat(),
                                    lng : e.latLng.lng(),
                                    icon:'${pageContext.request.contextPath}/vues/assets/icons/points/regroup.png',
                                    draggable : true
                                };

                                markers.push(map.addMarker(marker));
                                
                            }
                        }]
                });
                      
                      
                      
                $("#btn_valider").click(function(){
                    //console.log(markers);
                    var save_update_list=[];
                    var delete_list=[];
                        for(var i=0;i<markers.length;i++)
                        {
                            markers[i].point_interet.latitude = markers[i].getPosition().lat();
                            markers[i].point_interet.longitude = markers[i].getPosition().lng();
                            if((typeof markers[i].delete !== "undefined"))
                            {
                                if(markers[i].point_interet.id!=0)
                                {
                                    delete_list.push(markers[i].point_interet);
                                }
                                else
                                    continue;
                            }
                            else
                            {
                                save_update_list.push(markers[i].point_interet);
                            }
                        }
                        console.log("liste a supprimer");
                        console.log(JSON.stringify(delete_list));
                        console.log("a enregistrer");
                        console.log(JSON.stringify(save_update_list));
                        
                        $.ajax({
                            method: "PUT",
                            url: "${pageContext.request.contextPath}/json/points/save",
                            data:JSON.stringify(save_update_list),
                            processData: false,
                            contentType: "application/json"
                            }).done(function( e ) {
                                
                                
                                new PNotify({
                                        title: 'Points intérets',
                                        text: 'Vos modifications et ajouts ont été enregistrés',
                                        type: 'success'
                                });
                                
                            });
                            
                            
                        $.ajax({
                            method: "DELETE",
                            url: "${pageContext.request.contextPath}/json/points/delete",
                            data:JSON.stringify(delete_list),
                            processData: false,
                            contentType: "application/json"
                            }).done(function( e ) {
                                
                                
                                new PNotify({
                                        title: 'Points intérets',
                                        text: 'Vos suppressions ont été effectués également !',
                                        type: 'success'
                                });
                                
                            });    
                        
                });
                
                $("#modal_btn_valider").click(function(){
                    var marker_id = $("#modal_marker_id").val();
                    var nom = $("#modal_form_nom").val(); // je recupere les valeurs entrés dans le formulaire modal
                    var adresse = $("#modal_form_adresse").val();
                    var description = $("#modal_form_description").val();
                    var iconne = $("#modal_form_icone").val();
                    var info = new google.maps.InfoWindow({
                            //content: '<h5><strong>Nom : </strong>'+nom+'</h5><p><strong>Adresse : </strong>'+adresse+'<br/><strong>Description : </strong>'+description+'</p>'
                            content : content(nom,adresse,description,iconne)
                        });
                        
                    //alert(nom+" "+adresse+" "+description);
                    if(marker_id==-1) // si c est un nouveau ajout, j'ajoute les autres valeurs manquante
                    {
                        
                        
                        markers[markers.length-1].title = nom;
                        markers[markers.length-1].setIcon('${pageContext.request.contextPath}/vues/assets/icons/points/'+iconne);
                        markers[markers.length-1].infoWindow = info;
                        markers[markers.length-1].point_interet={'id':0,
                                'nom':nom,
                                'adresse':adresse,
                                'description':description,
                                'icone':iconne
                                };
                            
                                ajouter_point_menu(nom,(markers.length)-1);
                        console.log(markers[markers.length-1]);
                    }
                    else
                    {
                        markers[marker_id].title = nom;
                        markers[marker_id].infoWindow = info;
                        markers[marker_id].point_interet.nom = nom;
                        markers[marker_id].point_interet.adresse = adresse;
                        markers[marker_id].point_interet.description = description; 
                        markers[marker_id].point_interet.icone=iconne;
                        markers[marker_id].setIcon('${pageContext.request.contextPath}/vues/assets/icons/points/'+iconne);
                        $("li[data-marker-id="+marker_id+"]").children(":first").text(nom);
                    }
    
                });
                
                $("#modal_btn_annuler").click(function(){ // si c'est un ajout et je clique sur annuler, je supprime le dernier marker que j du ajouter
                    if($("#modal_marker_id").val()==(-1))
                    {
                        markers[markers.length-1].setMap(null);
                        markers.pop();
                    }
                    
                });
                
                
                
                function ajouter_point_menu(nom,idx){ // ajouter un <li> dans le menu a gauche
                    
                        var li = document.createElement("li");
                        var ahref1 = document.createElement("a");
                        li.setAttribute('data-marker-id',idx);
                        ahref1.setAttribute('class','location-action location-center');
                        ahref1.setAttribute('data-marker-center',idx);
                        ahref1.setAttribute('href','#');
                        var ahref2 = document.createElement("a");
                        
                        ahref2.setAttribute('class','location-action location-edit');
                        ahref2.setAttribute('data-marker-modif',idx);
                        ahref2.setAttribute('href','#');
                        var ahref3 = document.createElement("a");
                        
                        ahref3.setAttribute('class','location-action location-remove text-danger');
                        ahref3.setAttribute('data-marker-supp',idx);
                        ahref3.setAttribute('href','#');
                        
                        var ahref4 = document.createElement("a");
                        ahref4.setAttribute('class','location-action location-show-hide');
                        ahref4.setAttribute('data-marker-show-hide',idx);
                        ahref4.setAttribute('href','#');
                        
                        var i1 = document.createElement("i");
                        i1.setAttribute('class','fa fa-map-marker');
                        var i2 = document.createElement("i");
                        i2.setAttribute('class','fa fa-edit');
                        var i3 = document.createElement("i");
                        i3.setAttribute('class','fa fa-times');
                        
                        var i4 = document.createElement("i");
                        i4.setAttribute('class','fa fa-dot-circle-o');
                        
                        var p = document.createElement("p");
                        var textp = document.createTextNode(nom);
                        
                        p.appendChild(textp);
                        ahref1.appendChild(i1);
                        ahref2.appendChild(i2);
                        ahref3.appendChild(i3);
                        ahref4.appendChild(i4);
                        li.appendChild(p);
                        li.appendChild(ahref4);
                        li.appendChild(ahref1);
                        li.appendChild(ahref2);
                        li.appendChild(ahref3);
                        
                        
                        document.getElementById("MarkersList").appendChild(li);
                    
                    
                }
                
                $("body").on('click','a[data-marker-center]',function(e){
                    var index_marker = this.getAttribute("data-marker-center");
                    map.setCenter(markers[index_marker].getPosition().lat(),markers[index_marker].getPosition().lng());
                    for(var i=0;i<markers.length;i++)
                            markers[i].infoWindow.close();
                        
                    markers[index_marker].infoWindow.open(map.map,markers[index_marker]);
                });
                
                $("body").on('click','a[data-marker-supp]',function(e){
                    var index_marker = this.getAttribute("data-marker-supp");
                    $("#confirmSuppression").modal("show");
                    $("#modal_supp_id").val(index_marker);
                    
                });
                
                $("body").on('click','a[data-marker-show-hide]',function(e){
                    var index_marker = this.getAttribute("data-marker-show-hide");
                    var icon = $(this).children(":first");
                    if(icon.hasClass("fa-dot-circle-o"))
                    {
                        markers[index_marker].setVisible(false);
                        icon.removeClass("fa-dot-circle-o");
                        icon.addClass("fa-circle-o");
                    }
                    else
                    {
                        markers[index_marker].setVisible(true);
                        icon.removeClass("fa-circle-o");
                        icon.addClass("fa-dot-circle-o");
                    }
                });
                
                
                $("body").on('click','a[data-marker-modif]',function(e){
                    var index_marker = this.getAttribute("data-marker-modif");
                    $("#formulairePoint").modal("show"); 
                    $("#modal_marker_id").val(index_marker);
                    $("#modal_form_id").val(markers[index_marker].point_interet.id);
                    $("#modal_form_nom").val(markers[index_marker].point_interet.nom);
                    $("#modal_form_adresse").val(markers[index_marker].point_interet.adresse);
                    $("#modal_form_description").val(markers[index_marker].point_interet.description);
                    $("#modal_form_icone").val(markers[index_marker].point_interet.icone);
                    $(".iconne_map").removeClass("selected_iconne_map");
                    $(".iconne_map[data-icone-name='"+markers[index_marker].point_interet.icone+"']").addClass("selected_iconne_map");
                    
                });
                
                $("#modal_btn_supp").click(function(){
                    var index_marker = $("#modal_supp_id").val();
                    //alert("Suppresion d'un point a l'index "+index_marker);
                    markers[index_marker].setMap(null);
                    markers[index_marker].delete="true";
                    $("li[data-marker-id="+index_marker+"]").remove();
                });
                
                $(".iconne_map").click(function(){
                    if(!$(this).hasClass("selected_iconne_map"))
                     {   
                        $("#modal_form_icone").val(this.getAttribute("data-icone-name"));
                        
                        $(".iconne_map").removeClass("selected_iconne_map");
                        $(this).addClass("selected_iconne_map"); 
                     }
                     
                });
      });
    
    
    function content(nom,adresse,description,iconne){
        
      return '<div class="panel-body" style="width:250px;">'+
        '<div class="widget-summary-col widget-summary-col-icon">'+
'<div class="summary-icon bg-primary"><img src="${pageContext.request.contextPath}/vues/assets/icons/points/'+iconne+'" style="float:left;position:relative;top:-7px;margin-right:5px;"/><h4 class="title">'+nom+'</h4></div></div><div class="widget-summary-col">'+
'<br/><div class="summary"><div class="info" style="word-break:break-all;"><strong class="amount"> Adresse : </strong>'+adresse+'<br/><strong class="amount"> Description : </strong>'+description+'<br/>'+
'</div></div></div></div>';
    }
    
    
    
 
</script>
</html>
