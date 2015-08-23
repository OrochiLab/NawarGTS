
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="boxed">
    <jsp:include page="includes/header.jsp" />
	

			<div class="inner-wrapper">
                            <jsp:include page="includes/nav.jsp" />

				<section role="main" class="content-body">
					<header class="page-header">
						<h2>Accueil</h2>
					
						
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
														<button id="btn_valider" class="btn btn-primary btn-block mb-lg" type="button" data-toggle="modal" data-target="#MarkerModal">Valider</button>
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

                            

                            <jsp:include page="includes/footer.jsp"/>
<script>
       var points;
       var markers = [];
        $(document).ready(function(){
  
                var map = new GMaps({
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
                               content : '<h5><strong>Nom : </strong>'+points[i].nom+'</h5><p><strong>Adresse : </strong>'+points[i].adresse+'<br/><strong>Description : </strong>'+points[i].description+'</p>'
                            },
                            dragend:function(e){
                                //console.log(this);
                                //alert('Drag vers : '+this.getPosition().lng()+' '+this.getPosition().lat());
                                //markers[markers.indexOf(this)].lat = this.getPosition().lat();
                            }
                        };
                        markers.push(map.addMarker(marker));
                        markers[markers.length-1].point_interet={'id':points[i].id,
                            'nom':points[i].nom,
                            'adresse':points[i].adresse,
                            'description':points[i].description,
                            'iconne':'default'};
                        
                        
                        //markers.push(marker);
                        
                        var li = document.createElement("li");
                        var ahref1 = document.createElement("a");
                        ahref1.setAttribute('class','location-action location-center');
                        ahref1.setAttribute('href','#');
                        var ahref2 = document.createElement("a");
                        ahref2.setAttribute('class','location-action location-edit');
                        ahref1.setAttribute('href','#');
                        var ahref3 = document.createElement("a");
                        ahref3.setAttribute('class','location-action location-remove text-danger');
                        ahref1.setAttribute('href','#');
                        var i1 = document.createElement("i");
                        i1.setAttribute('class','fa fa-map-marker');
                        var i2 = document.createElement("i");
                        i2.setAttribute('class','fa fa-edit');
                        var i3 = document.createElement("i");
                        i3.setAttribute('class','fa fa-times');
                        var p = document.createElement("p");
                        var textp = document.createTextNode(points[i].nom);
                        
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
                  });
                
                  map.setContextMenu({
                        control: 'map',
                        options: [{
                          title: 'Ajouter un point',
                          name: 'ajouter_point',
                          action: function(e) {
                              alert("Choix menu ajout point !");
                          }
                        }]
                      });
                      
                      
                      
                $("#btn_valider").click(function(){
                    //console.log(markers);
                        for(var i=0;i<markers.length;i++)
                        {
                            markers[i].point_interet.latitude = markers[i].getPosition().lat();
                            markers[i].point_interet.longitude = markers[i].getPosition().lng();
                            console.log(JSON.stringify(markers[i].point_interet));
                            $.ajax({
                            method: "PUT",
                            url: "${pageContext.request.contextPath}/json/save",
                            data:JSON.stringify(markers[i].point_interet),
                            processData: false,
                            contentType: "application/json"
                            }).done(function( e ) {
                                
                                
                                        new PNotify({
                                                title: 'Points intérets',
                                                text: 'Vos modifications ont été enregistrés',
                                                type: 'success'
                                        });
                                
                            });
                        }
                });
      });
    
  
</script>
</html>
