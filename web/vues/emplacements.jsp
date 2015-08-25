
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
                            <jsp:include page="includes/nav.jsp" />

				<section role="main" class="content-body">
					<header class="page-header">
						<h2>Emplacements</h2>
					
						
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
											</div>
                                                                                        
                                                                                        <p class="title">Véhicules par groupe</p>

											<div class="form-group">
												<ul id="VehicleList" class="list-markers list-unstyled mb-lg">
                                                                                                    <c:set var="compt" value="0"/>
                                                                                                    <c:forEach items="${groupes}" var="groupe">
                                                                                                        <li>
                                                                                                            <strong><c:out value="${groupe.nom}" /></strong>
                                                                                                            <ul>
                                                                                                                <c:forEach items="${groupe.vehicules}" var="vehicule">
                                                                                                                    <c:if test="${vehicule.position_actuelle!=null}">
                                                                                                                        <li>
                                                                                                                            <p><c:out value="${vehicule.intitule}" /></p>
                                                                                                                            <a data-vehicule-center="${compt}" class="location-action location-center" href="#"><i class="fa fa-map-marker"></i></a>
                                                                                                                            <a data-vehicule-show-hide="${compt}" class="location-action location-show-hide" href="#"><i class="fa fa-dot-circle-o"></i></a>
                                                                                                                            <c:set var="compt" value="${compt+1}"/>

                                                                                                                        </li>
                                                                                                                    </c:if>

                                                                                                                </c:forEach>
                                                                                                            </ul>    
                                                                                                        
                                                                                                        </li>
                                                                                                    </c:forEach>
												</ul>
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
                          
<div class="modal fade" id="modaldistances" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
            <div class="modal-content">
                    <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myModalLabel">Liste des distances par rapport a : <span id="modal-nom-point"></span></h4>
                    </div>
                    <div class="modal-body">
                             <table class="table table-striped mb-none">
                                <thead>
                                    <tr>

                                        <th> - </th>
                                        <th>Véhicule</th>
                                        <th>Distance</th>
                                        <th>Distance (Sur route)</th>
                                    </tr>
                                </thead>
                                <tbody id="modal-corp-table">
                                </tbody>
                             </table>

                    </div>
                    <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
                            <input type="hidden" id="name_vehicule_tracer" />
                            <input type="hidden" id="index_point" />
                            
                            <button id="modal_btn_tracer" type="button" class="btn btn-primary" data-dismiss="modal">Tracer le chemin court</button>
                            

                    </div>
            </div>
    </div>
</div> 
                            <jsp:include page="includes/footer.jsp"/>
<script>
       var points;
       var markers = [];
       var positions = [];
       var map;
       var count_callbacks;
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
                            title : points[i].nom,
                            infoWindow:{
                               
                               content : content(points[i].nom,points[i].adresse,points[i].description,points[i].icone)
                            },
                            icon:'${pageContext.request.contextPath}/vues/assets/icons/points/'+points[i].icone
                        };
                        markers.push(map.addMarker(marker));
                        
                        
                        ajouter_point_menu(points[i].nom,(markers.length)-1);
                     
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
                        ahref2.setAttribute('class','location-action location-show-hide');
                        ahref2.setAttribute('data-marker-show-hide',idx);
                        ahref2.setAttribute('href','#');
                        
                        var ahref3 = document.createElement("a");
                        ahref3.setAttribute('class','location-action location-edit');
                        ahref3.setAttribute('data-marker-distances',idx);
                        ahref3.setAttribute('href','#');
                        
                        var i1 = document.createElement("i");
                        i1.setAttribute('class','fa fa-map-marker');
                        
                        var i2 = document.createElement("i");
                        i2.setAttribute('class','fa fa-dot-circle-o');
                        
                        var i3 = document.createElement("i");
                        i3.setAttribute('class','fa fa-road');
                        
                        
                        var p = document.createElement("p");
                        var textp = document.createTextNode(nom);
                        
                        p.appendChild(textp);
                        ahref1.appendChild(i1);
                        ahref2.appendChild(i2);
                        ahref3.appendChild(i3);
                        
                        li.appendChild(p);
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
                    for(var i=0;i<positions.length;i++)
                            positions[i].infoWindow.close();
                        
                    markers[index_marker].infoWindow.open(map.map,markers[index_marker]);
                    
                    
                });
                
                
                $("body").on('click','a[data-marker-distances]',function(e){
                    //map.removePolylines();
                    var index_marker = this.getAttribute("data-marker-distances");
                    $("#index_point").val(index_marker);
                    $("#modal-nom-point").html(markers[index_marker].title);
                    
                    var point = new google.maps.LatLng(markers[index_marker].getPosition().lat(),markers[index_marker].getPosition().lng());
                    $("#modal-corp-table").empty();
                    var min=Number.MAX_VALUE;
                    var min_driving = Number.MAX_VALUE;
                    var pos=-1;
                    var pos_driving=-1;
                    
                    
                    for(var i=0;i<positions.length;i++)
                    {
                        var vehicule = new google.maps.LatLng(positions[i].getPosition().lat(),positions[i].getPosition().lng());
                        var dist = Number.parseInt(distance(point,vehicule));
                        
                        if(dist<min){
                            
                            min = dist;
                            pos=i;
                            
                        }
                        
                        var tr = document.createElement("tr");
                        var td1 = document.createElement("td");
                        var td2 = document.createElement("td");
                        var td3 = document.createElement("td");
                        var td4 = document.createElement("td");
                        
                        var img = document.createElement("img");
                        img.setAttribute("src",'${pageContext.request.contextPath}/vues/assets/icons/vehicules/car.png');
                        td1.appendChild(img);
                        td2.appendChild(document.createTextNode(positions[i].title));
                        td3.appendChild(document.createTextNode(dist+" m"));
                        td4.appendChild(document.createTextNode(""));
                        tr.appendChild(td1);
                        tr.appendChild(td2);
                        tr.appendChild(td3);
                        tr.appendChild(td4);
                        document.getElementById("modal-corp-table").appendChild(tr);
                        count_callbacks=0;
                        (function(indice){
                            
                            map.drawRoute({
                                origin: [markers[index_marker].getPosition().lat(),markers[index_marker].getPosition().lng()],
                                destination: [positions[indice].getPosition().lat(),positions[indice].getPosition().lng()],
                                travelMode: 'driving',
                                strokeColor: '#131540',
                                strokeOpacity: 00,
                                strokeWeight: 6,
                                callback: function (e) {
                                        //var time = 0;
                                        var dist_driving = 0;
                                        for (var i=0; i<e.legs.length; i++) {
                                            //time += e.legs[i].duration.value;
                                            dist_driving += e.legs[i].distance.value;
                                        }
                                        //console.log(time+' Seconds');
                                        console.log(dist_driving+' Metres');
                                        $("#modal-corp-table tr:nth-child("+(indice+1)+") td:nth-child(4)").text(dist_driving);
                                        count_callbacks++;
                                        if(count_callbacks==positions.length)
                                         {   
                                             for(var j=0;j<positions.length;j++)
                                             {
                                                 if(Number.parseInt($("#modal-corp-table tr:nth-child("+(j+1)+") td:nth-child(4)").text())<min_driving){
                                                     
                                                    min_driving = Number.parseInt($("#modal-corp-table tr:nth-child("+(j+1)+") td:nth-child(4)").text());
                                                    pos_driving=j;

                                                    }
                                             }
                                             if(pos_driving!==(-1))
                                            {
                                                $("#modal-corp-table tr:nth-child("+(pos_driving+1)+") td:nth-child(4)")
                                                    .css("color","green")
                                                    .css("font-weight","bold")
                                                    .addClass("appear-animation flash appear-animation-visible");  
                                                $("#name_vehicule_tracer").val(pos_driving);
                                            }
                                        }
                                         
                                    }
                            });
                        })(i);
                        
                        
                    }
                   
                    if(pos!==(-1))
                    {
                        $("#modal-corp-table tr:nth-child("+(pos+1)+") td:nth-child(3)")
                            .css("color","green")
                            .css("font-weight","bold")
                            .addClass("appear-animation flash appear-animation-visible");  
                    }
                    
                    $("#modaldistances").modal("show");
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
                
                
                $.ajax({
                  method: "GET",
                  url: "${pageContext.request.contextPath}/json/positions"
                }).done(function( groupes ) {
                    
                    for(var i=0;i<groupes.length;i++)
                    {
                       for(var j=0;j<groupes[i].vehicules.length;j++)
                       {
                        if(groupes[i].vehicules[j].position_actuelle!==null)
                        {
                            var pos = groupes[i].vehicules[j].position_actuelle;
                            var datef = new Date(pos.timestamp);
                            pos.timestamp = datef.getDate()+'/'+(datef.getMonth()+1)+'/'+datef.getFullYear()+' '+
                                    ((datef.getHours().toString().length===1)?'0'+datef.getHours().toString():datef.getHours().toString())+':'+
                                    ((datef.getMinutes().toString().length===1)?'0'+datef.getMinutes().toString():datef.getMinutes().toString())+':'+
                                    ((datef.getSeconds().toString().length===1)?'0'+datef.getSeconds().toString():datef.getSeconds().toString());
                            
                                pos.vehicule={
                                    'id':groupes[i].vehicules[j].id,
                                    'intitule':groupes[i].vehicules[j].intitule,
                                    'matricule':groupes[i].vehicules[j].matricule,
                                    'modele':groupes[i].vehicules[j].modele,
                                    'type':groupes[i].vehicules[j].type,
                                    'chauffeur':groupes[i].vehicules[j].chauffeur,
                                    'groupe':groupes[i].nom
                                };
                            
                                var marker = {
                                    lat : pos.latitude,
                                    lng : pos.longitude,
                                    title : pos.vehicule.intitule,
                                    infoWindow:{
                                       content : content_vehicule(pos.vehicule.intitule,pos.vehicule.matricule,pos.vehicule.chauffeur.nom+' '+
                                               pos.vehicule.chauffeur.prenom,pos.timestamp,pos.vehicule.groupe,'car.png')
                                       
                                    },
                                    icon:'${pageContext.request.contextPath}/vues/assets/icons/vehicules/car.png'
                                };
                                positions.push(map.addMarker(marker));
                                positions[(positions.length)-1].position_actuelle = pos;
                                console.log(positions[(positions.length)-1]);
                        }
                       }
                     
                    }
                  });
                  
                  $("body").on('click','a[data-vehicule-center]',function(e){
                    var index_marker = this.getAttribute("data-vehicule-center");
                    map.setCenter(positions[index_marker].getPosition().lat(),positions[index_marker].getPosition().lng());
                        for(var i=0;i<positions.length;i++)
                            positions[i].infoWindow.close();
                        for(var i=0;i<markers.length;i++)
                            markers[i].infoWindow.close();
                        
                    positions[index_marker].infoWindow.open(map.map,positions[index_marker]);
                    
                    });
                  
                
                $("body").on('click','a[data-vehicule-show-hide]',function(e){
                    var index_marker = this.getAttribute("data-vehicule-show-hide");
                    var icon = $(this).children(":first");
                    if(icon.hasClass("fa-dot-circle-o"))
                    {
                        positions[index_marker].setVisible(false);
                        icon.removeClass("fa-dot-circle-o");
                        icon.addClass("fa-circle-o");
                    }
                    else
                    {
                        positions[index_marker].setVisible(true);
                        icon.removeClass("fa-circle-o");
                        icon.addClass("fa-dot-circle-o");
                    }
                });
                
                
                $("#modal_btn_tracer").click(function(){
                    var vehicule_destination = Number.parseInt($("#name_vehicule_tracer").val());
                    var index_point = Number.parseInt($("#index_point").val());
                    map.drawRoute({
                                origin: [markers[index_point].getPosition().lat(),markers[index_point].getPosition().lng()],
                                destination: [positions[vehicule_destination].getPosition().lat(),positions[vehicule_destination].getPosition().lng()],
                                travelMode: 'driving',
                                strokeColor: 'green',
                                strokeOpacity: 1,
                                strokeWeight: 5
                            });
                    positions[vehicule_destination].infoWindow.open(map.map,positions[vehicule_destination]);
                });
                
                map.setContextMenu({
                        control: 'map',
                        options: [{
                            title: 'Effacer les routes',
                            name: 'effacer_routes',
                            action: function(e) {
                               
                                map.removePolylines();
                            }
                        }]
                });
    
    });
    function content(nom,adresse,description,iconne){
        
      return '<div class="panel-body" style="width:250px;">'+
        '<div class="widget-summary-col widget-summary-col-icon">'+
'<div class="summary-icon bg-primary"><img src="${pageContext.request.contextPath}/vues/assets/icons/points/'+iconne+'" style="float:left;position:relative;top:-7px;margin-right:5px;"/><h4 class="title">'+nom+'</h4></div></div><div class="widget-summary-col">'+
'<br/><div class="summary"><div class="info" style="word-break:break-all;"><strong class="amount"> Adresse : </strong>'+adresse+'<br/><strong class="amount"> Description : </strong>'+description+'<br/>'+
'</div></div></div></div>';
    }
    
    function content_vehicule(intitule,matricule,chauffeur,timestamp,groupe,iconne){
        
      return '<div class="panel-body" style="width:250px;">'+
        '<div class="widget-summary-col widget-summary-col-icon">'+
'<div class="summary-icon bg-primary"><img src="${pageContext.request.contextPath}/vues/assets/icons/vehicules/'+iconne+'" style="float:left;position:relative;top:-7px;margin-right:5px;"/><h4 class="title">'+intitule+'</h4></div></div><div class="widget-summary-col">'+
'<br/><div class="summary"><div class="info" style="word-break:break-all;">'+
'<strong class="amount"> Matricule : </strong>'+matricule+'<br/>'+
'<strong class="amount"> Chauffeur : </strong>'+chauffeur+'<br/>'+
'<strong class="amount"> Groupe : </strong>'+groupe+'<br/>'+
'<strong class="amount"> Date : </strong>'+timestamp+'<br/>'+
'</div></div></div></div>';
    }
    
    function distance(p1, p2){
        return (google.maps.geometry.spherical.computeDistanceBetween(p1, p2)).toFixed(0);
      }
      
 
</script>
</html>
