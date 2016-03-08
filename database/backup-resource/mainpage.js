var tinyfw = angular.module('tinyfw', ["ui.router", "ngAnimate", "tinyfw.factory", "tinyfw.directive", "oc.lazyLoad", "chieffancypants.loadingBar"]).run(function($rootScope, cfpLoadingBar){
                $rootScope.jsHash = '{hash}';
                $rootScope.isContainer = true;
                $rootScope.isFull = false;
                
                $rootScope.$on('$stateChangeStart', function() {
                  cfpLoadingBar.start();
                  
                  //-- Destroy plupload when next page
                  if($rootScope.html5Upload){
                        $rootScope.html5Upload.destroy();
                        delete $rootScope.html5Upload;
                  }
                                         
                })
            
                $rootScope.$on('$stateChangeSuccess', function() {
                  cfpLoadingBar.complete();
                })
                
                $rootScope.$on('$stateChangeError', function(){
                    alert('Error!');
                    window.location.reload();
                })
        })
        tinyfw.config(function($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider, cfpLoadingBarProvider){
          //-- Url default
          cfpLoadingBarProvider.includeSpinner = true;
          $httpProvider.interceptors.push('tinyajaxHanding');
          $urlRouterProvider.otherwise(PATH_)
          $stateProvider
            .state('/', {
                url: PATH_+'?__hung&__lanvi',
                templateUrl: function($stateParams){
                    var p = tn.makeQueryString($stateParams);
                    return URL_SERVER+p;
                },
                controller: function($rootScope){
                    $rootScope.isContainer = false;
                }
            })
            .state('home', {
                url: PATH_+"home",
                templateUrl: URL_SERVER+'home',
                controller: function($scope, $stateParams, $rootScope, $tiny){
                    $tiny.alert();
                    $scope.submit = function(t){
                        var ajax = $tiny.ajax({
                            url: URL_SERVER + 'welcome/test/HUNG',
                            data: t
                        })
                        
                        ajax.success(function(data){
                            $tiny.alert(data.content, 'Send Successfully');
                        })
                    }
                    $scope.alert = function(content, title){
                        $tiny.alert(content, title);
                    }
                }
            })
            .state('post', {
                url: PATH_+"post/{id:[0-9a-fA-F]{1,8}}:SEO",
                templateUrl: function($stateParams){
                    return URL_SERVER + 'post/'+$stateParams.id;
                },
                controller: function($scope, $rootScope, $tiny){
                    $scope.click = function(){
                        
                    };
                }
            })
            .state('drag', {
                url: PATH_+"drag",
                templateUrl: URL_SERVER+'drag',
                resolve: {
    				jqueryUI: function($ocLazyLoad){
    					return $ocLazyLoad.load([
                            '{r}/css/jquery-ui-custom.css'
    					]);
    				}
                },
                controller: function($scope, $timeout, $tiny, $rootScope){
                    $rootScope.isContainer = true;
                    $scope.images = [];
                    $scope.add = function(){
                        $scope.images.push({
                            src: 'http://photo.webketoan.vn/upanh/images/2015/04/24/IMG_1676.th.jpg', 
                            origin: 'http://photo.webketoan.vn/upanh/images/2015/04/24/IMG_1676.jpg',
                            show: 'block'
                        });
                    }
                    
                    //-- function update scope when uploaded
                    $scope.update = function(var_, index_, value_, param_){
                        if(param_)
                            $scope[var_][index_][param_] = value_;
                        else{
                            if(value_ != null)
                                $scope[var_][index_] = angular.extend({}, $scope[var_][index_], value_);
                            else
                                $scope[var_].splice(index_, 1);
                        }
                        if(value_ != null)
                            $scope.$digest();
                    }
                    
                    //-- delete one element
                    $scope.Delete = function(path, id){
                        $scope.update('images', id, null);
                        
                        path = path.split('|');
                        $tiny.ajax({
                            url: URL_SERVER + 'welcome/Delete?path=uploads',
                            data: {
                                folder: path[0],
                                filename: path[1]
                            }
                        })
                    }
                    
                    $rootScope.$on('test', function(event, mass){
                        $scope.Delete(mass[0], mass[1]);
                    })
                    
                    //-- create new image when start upload
                    $scope.pushStack = function(var_, value_, iid_){
                        if(iid_)
                            $scope[var_][iid_] = value_;
                        else
                            return $scope[var_].push(value_);
                    }
                    
                    $scope.tinydropped = function(xEl, dEl, index){
                        xEl = jQuery('[access-tiny-id="'+xEl+'"]');
                        dEl = jQuery('[access-tiny-id="'+dEl+'"]');
                        
                        var x = xEl.clone();
                        xEl = x;
                        var clone = $('<div class="imgDrag" />').append($('<div />').append(xEl).html());
                            clone.find('img.responsive-img').attr('src', xEl.attr('origin-src')).removeAttr('style');
                            dEl.append(clone.attr("draggable", "false"));
                            clone.draggable({ containment: "parent", cursor: 'move' });
                            
                            if(xEl.is('img')){
                                $scope.update('images', index, 'none', 'show');
                                clone.click(function(){
                                    //clone.addClass('resizing');
                                    $(this).resizable({
                                      containment: "parent",
                                      aspectRatio: true,
                                      create: function(event, ui){
                                        setTimeout(function(){
                                            var t = jQuery(event.target);
                                            t.addClass('resizing');
                                            if(!t.find('.removeDraged').length){
                                                t.append(
                                                    jQuery('<i data-index="'+index+'" class="mdi-navigation-close removeDraged"></i>').click(function(){
                                                         var $t = $(this);
                                                         $scope.update('images', $t.data('index'), 'block', 'show')
                                                         $t.parent('.imgDrag').remove();
                                                         dEl.attr('tiny-drag-target', 'true');
                                                    })
                                                );
                                            }
                                        },500);
                                      }
                                    });
                                })
                                var s = tn.calculateAspectRatioFit(clone.width(), clone.height(), dEl.width() - 10, dEl.height() - 10);
                                clone.css({width: s.width, height: s.height})
                            }else{
                                xEl.hide();
                            }
                    }
                    $scope.status = "Select file";
                    $scope.onAddfile = function(up, files){
                        $scope.status = "Select file...";
                        angular.forEach(files, function(value, key){
                            var image = tn.initLoading(tinyConfig.thumbSize, value.id);
                            $timeout(function(){
                                var num = $scope.pushStack('images', {
                                    src: image.src, 
                                    origin: image.src,
                                    show: 'block',
                                    id: image.iid,
                                    path: null
                                }, $scope.length);
                            },10);
                        })   
                    }
                    
                    $scope.onUploaded = function(respon, file){
                        respon = angular.fromJson(respon);
                        $timeout(function(){
                            var elementImage = jQuery('#'+file.id);
                            $scope.update('images', elementImage.data('index'), tn.getURLUploaded(respon.folder, respon.filename));
                        },100);
                    }
                }
            })
            $locationProvider.html5Mode({
              enabled: true,
              requireBase: false
            });
        })
		
		
		
		
		
		
		
		
		
		
		
		
		
		$state.go('admin.administrator',
                {
                    __page : 2,
                    module : 'peoples'
                },
                {
                    location: 'replace', //  update url and replace
                    inherit: false,
                    notify: false
                });