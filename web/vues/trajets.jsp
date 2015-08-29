
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="boxed">
    <jsp:include page="includes/header.jsp" />
    

			<div class="inner-wrapper">
                            <jsp:include page="includes/nav.jsp" >
                                <jsp:param name="bloc" value="maps" />
                            </jsp:include>
				<section role="main" class="content-body">
					<header class="page-header">
						<h2>Trajets</h2>
					
						
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

											<div class="form-group">
												<label class="control-label">Véhicule :</label><br/>
                                                                                                <div class="input-group btn-group">
                                                                                                    <span class="input-group-addon">
                                                                                                            <i class="fa fa-car"></i>
                                                                                                    </span>
                                                                                                    <select id="form_id_vehicule" class="form-control">
                                                                                                        <c:forEach items="${vehicules}" var="vehicule" >
                                                                                                            <option value="${vehicule.id}"><c:out value="${vehicule.intitule}" /></option>
                                                                                                        </c:forEach>
                                                                                                    </select>
                                                                                                </div>
                                                                                        </div>
                                                                                        
                                                                                        <div class="form-group">
                                                                                            <label class="control-label">Date début</label><br/>
                                                                                            <div class="input-group btn-group">
                                                                                                <span class="input-group-addon">
                                                                                                    <i class="fa fa-calendar"></i>
                                                                                                </span>
												<input type="text" id="form_date_debut" class="form-control">
                                                                                            </div>    
											</div>
                                                                                        
                                                                                        <div class="form-group">
                                                                                            <label class="control-label">Date fin</label><br/>
                                                                                            <div class="input-group btn-group">
                                                                                                <span class="input-group-addon">
                                                                                                    <i class="fa fa-calendar"></i>
                                                                                                </span>
												<input type="text" id="form_date_fin" class="form-control">
                                                                                            </div>    
											</div>
                                                                                        <br/>
                                                                                        <button id="form_btn" class="btn btn-primary btn-block">Valider</button>
                                                                                        <hr class="separator">
                                                                                        <p id="p_distance_parcourue" style="text-align:center;display:none;">Distance parcourue :<br/>
                                                                                        <strong style="color:green;font-size: 1.2em;" id="distance_parcourue">0</strong> Mètres</p>
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
                            <script src="${pageContext.request.contextPath}/vues/assets/vendor/jquery-maskedinput/jquery.maskedinput.js"></script>

<script>

       //var positions = [];
       var map;
        $(document).ready(function(){

               $('#form_date_debut').mask("99/99/9999");
               $('#form_date_fin').mask("99/99/9999");
               
            $("#form_btn").click(function(){
                
                //alert($("#form_id_vehicule").val()+" "+$("#form_date_debut").val()+" "+$("#form_date_fin").val());
                
                /*map = new GMaps({
			div: '#map',
			lat: -12.043333,
			lng: -77.028333
		});*/
                $("#distance_parcourue").text("0");
                $.ajax({
                  url: "${pageContext.request.contextPath}/json/trajet",
                  method: "POST",
                  data:{
                      'id_vehicule':$("#form_id_vehicule").val(),
                      'date_debut':$("#form_date_debut").val(),
                      'date_fin':$("#form_date_fin").val()   
                  }
                }).done(function(positions) {
                    
                    map = new GMaps({
			div: '#map',
			lat: -12.043333,
			lng: -77.028333
                    });
                    var datefin = new Date(positions[positions.length-1].timestamp);
                        var datefin_string = datefin.getDate()+'/'+(datefin.getMonth()+1)+'/'+datefin.getFullYear()+' '+
                                    ((datefin.getHours().toString().length===1)?'0'+datefin.getHours().toString():datefin.getHours().toString())+':'+
                                    ((datefin.getMinutes().toString().length===1)?'0'+datefin.getMinutes().toString():datefin.getMinutes().toString())+':'+
                                    ((datefin.getSeconds().toString().length===1)?'0'+datefin.getSeconds().toString():datefin.getSeconds().toString());
                    map.setCenter(positions[0].latitude,positions[0].longitude);
                    for(var i=0;i<positions.length-1;i++)
                    {
                        map.drawRoute({
                                origin: [positions[i].latitude,positions[i].longitude],
                                destination: [positions[i+1].latitude,positions[i+1].longitude],
                                travelMode: 'driving',
                                strokeColor: '#131540',
                                strokeOpacity: 1,
                                strokeWeight: 5,
                                callback: function (e) {
                                        //var time = 0;
                                        var dist_driving = 0;
                                        for (var i=0; i<e.legs.length; i++) {
                                            //time += e.legs[i].duration.value;
                                            dist_driving += e.legs[i].distance.value;
                                        }
                                        //console.log(time+' Seconds');
                                        
                                        $("#distance_parcourue").text(dist_driving+Number.parseInt($("#distance_parcourue").text()))
                                    }
                                });
                        var datef = new Date(positions[i].timestamp);
                        var date_string = datef.getDate()+'/'+(datef.getMonth()+1)+'/'+datef.getFullYear()+' '+
                                    ((datef.getHours().toString().length===1)?'0'+datef.getHours().toString():datef.getHours().toString())+':'+
                                    ((datef.getMinutes().toString().length===1)?'0'+datef.getMinutes().toString():datef.getMinutes().toString())+':'+
                                    ((datef.getSeconds().toString().length===1)?'0'+datef.getSeconds().toString():datef.getSeconds().toString());
                            
                        if(i===0 || i===(positions.length-2))  
                        {
                            if(i!==0)
                            {
                                    var marker = {
                                    lat : positions[i].latitude,
                                    lng : positions[i].longitude,
                                    title : 'Point',
                                    infoWindow:{

                                       content : '<h5><strong>Date : </strong>'+date_string+'</h5>'+
                                           '<h5><strong>Latitude : </strong>'+positions[i].latitude+'</h5>'+
                                           '<h5><strong>Longitude : </strong>'+positions[i].longitude+'</h5>'
                                    },
                                    icon:'${pageContext.request.contextPath}/vues/assets/icons/letters/information.png'
                                    };
                                map.addMarker(marker);
                            }
                            var marker = {
                                lat : ((i===0)?positions[i].latitude:positions[i+1].latitude),
                                lng : ((i===0)?positions[i].longitude:positions[i+1].longitude),
                                title : 'Début',
                                infoWindow:{

                                   content : '<h4>'+((i===0)?'Début':'Fin')+' du trajet</h4><strong>Date : </strong>'+((i===0)?date_string:datefin_string)+
                                           '<h5><strong>Latitude : </strong></h5>'+positions[(i===0)?i:(i+1)].latitude+
                                           '<h5><strong>Longitude : </strong></h5>'+positions[(i===0)?i:(i+1)].longitude
                                },
                                icon:'${pageContext.request.contextPath}/vues/assets/icons/letters/'+((i===0)?'letter_d.png':'letter_f.png')
                            };
                            map.addMarker(marker);
                        }
                        else
                        {
                            var marker = {
                                lat : positions[i].latitude,
                                lng : positions[i].longitude,
                                title : 'Point',
                                infoWindow:{

                                   content : '<h5><strong>Date : </strong>'+date_string+'</h5>'+
                                           '<h5><strong>Latitude : </strong>'+positions[i].latitude+'</h5>'+
                                           '<h5><strong>Longitude : </strong>'+positions[i].longitude+'</h5>'
                                },
                                icon:'${pageContext.request.contextPath}/vues/assets/icons/letters/information.png'
                                
                            };
                            map.addMarker(marker);
                        }
                        
                    }
                    
                    $("#p_distance_parcourue").show();
                    
                });
            });
                
                  
});
                
 
</script>
</html>
