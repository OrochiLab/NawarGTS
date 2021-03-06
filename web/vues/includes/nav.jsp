<!-- start: sidebar -->
				<aside id="sidebar-left" class="sidebar-left">
				
					<div class="sidebar-header">
						<div class="sidebar-title">
							Navigation
						</div>
						<div class="sidebar-toggle hidden-xs" data-toggle-class="sidebar-left-collapsed" data-target="html" data-fire-event="sidebar-left-toggle">
							<i class="fa fa-bars" aria-label="Toggle sidebar"></i>
						</div>
					</div>
				
					<div class="nano">
						<div class="nano-content">
							<nav id="menu" class="nav-main" role="navigation">
								<ul class="nav nav-main">
									<li>
                                                                            <a href="${pageContext.request.contextPath}/accueil" >
											<i class="fa fa-home" aria-hidden="true"></i>
											<span>Accueil</span>
										</a>
									</li>
									
									
									<li class="nav-parent ${(param.bloc=='administration')?'nav-expanded':''}">
										<a>
                                                                                    <i class="fa fa-tasks" aria-hidden="true"></i>
                                                                                    <span>Administration</span>
										</a>
										<ul class="nav nav-children">
                                                                                        <li>
												<a href="${pageContext.request.contextPath}/utilisateurs">
													 Utilisateurs
												</a>
											</li>
											<li>
												<a href="${pageContext.request.contextPath}/vehicules">
													 Vehicules
												</a>
											</li>
                                                                                        <li>
												<a href="${pageContext.request.contextPath}/groupes">
													 Groupes
												</a>
											</li>
                                                                                        <li>
												<a href="${pageContext.request.contextPath}/chauffeurs">
													 Chauffeurs
												</a>
											</li>	
                                                                                        <li>
												<a href="${pageContext.request.contextPath}/pointsInteret">
													 Points d'inter�t
												</a>
											</li>
										</ul>
									</li>
									
									<li class="nav-parent ${(param.bloc=='maps')?'nav-expanded':''}">
										<a>
											<i class="fa fa-map-marker" aria-hidden="true"></i>
											<span>Maps</span>
										</a>
										<ul class="nav nav-children">
											<li>
												<a href="${pageContext.request.contextPath}/emplacements">
													 Emplacements/Positions
												</a>
											</li>
											<li>
												<a href="${pageContext.request.contextPath}/trajets">
													 Trajets
												</a>
											</li>
											
										</ul>
									</li>
									
								</ul>
							</nav>
				
							<hr class="separator" />
				
							
						</div>
				
					</div>
				
				</aside>
				<!-- end: sidebar -->