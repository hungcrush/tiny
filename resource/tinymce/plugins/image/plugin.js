/*global tinymce:true */

tinymce.PluginManager.add('image', function(editor, url) {
	function showDialog() {
		var win3, data, dom = editor.dom, imgElm = editor.selection.getNode();
		var width, height, query_str = "";

		if(imgElm.nodeName == "IMG" && !imgElm.getAttribute('data-mce-object')){
			query_str = "?title=" + dom.getAttrib(imgElm, 'title') + "&alt=" + dom.getAttrib(imgElm, 'alt') + "&width=" + dom.getAttrib(imgElm, 'width') + "&height=" + dom.getAttrib(imgElm, 'height') + "&src=" + encodeURIComponent(dom.getAttrib(imgElm, 'src'));
			if(dom.getStyle(imgElm, 'float')){
				query_str += "&align=" + dom.getStyle(imgElm, 'float');
			}
		}else{
			imgElm = null;
		}

		function GetTheHtml(){
			var html = '';
			if(imgElm){
				var src = dom.getAttrib(imgElm, "src");
				if(src.charAt(3) != 'http' && src.charAt(1) == '//') alert(1);
				else{
					alert('no');
				}
				html += '<input type="hidden" name="src" id="src" value="' + src + '"/>';
				html += '<input type="hidden" name="alt" id="alt" value="' + dom.getAttrib(imgElm, "alt") + '"/>';
				html += '<input type="hidden" name="title" id="title" value="' + dom.getAttrib(imgElm, "title") + '"/>';
				html += '<input type="hidden" name="width" id="width" value="' + dom.getAttrib(imgElm, "width") + '"/>';
				html += '<input type="hidden" name="height" id="height" value="' + dom.getAttrib(imgElm, "height") + '"/>';
				html += '<input type="hidden" name="linkURL" id="linkURL" />';
				html += '<input type="hidden" name="target" id="target" />';
				html += '<input type="hidden" name="align" id="align" value="' + dom.getStyle(imgElm, 'float') + '"/>';
				var respon = 0;
				if(dom.getAttrib(imgElm, "class") == 'img-responsive') respon = 1;
				html += '<input type="hidden" name="responsive" id="responsive" value="' + respon + '" />';
				
				var thumbnail = 0;
				alert(dom.parent('a').length);
				html += '<iframe src="'+ url + '/image.php'+ query_str + '&' + new Date().getTime() + '" frameborder="0"></iframe>';
			}else{
				html += '<input type="hidden" name="src" id="src" />';
				html += '<input type="hidden" name="alt" id="alt" />';
				html += '<input type="hidden" name="title" id="title" />';
				html += '<input type="hidden" name="width" id="width" />';
				html += '<input type="hidden" name="height" id="height" />';
				html += '<input type="hidden" name="linkURL" id="linkURL" />';
				html += '<input type="hidden" name="target" id="target" />';
				html += '<input type="hidden" name="align" id="align" />';
				html += '<input type="hidden" name="responsive" id="responsive" />';
				html += '<iframe src="'+ url + '/image.php'+ '?' + new Date().getTime() + '" frameborder="0"></iframe>';
			}
			
			
			return html;
		}
		
		function BuildDom(src, alt, w, h, title, linkURL, target, float, res){
			if(imgElm){
				if(src){
					dom.setStyle(imgElm, 'float', float);
					
					dom.setAttribs(imgElm, {
						'src': src,
						'alt': alt ? alt : null,
						'width': w ? w : null,
						'height': h ? h : null,
						'title': title ? title : null
					});
					
				}
			}else{
				var markup = '';
				if(src){
					markup += '<img src="' + src + '"';
					if(alt){
						markup += ' alt="' + alt + '"';
					}
					if(title){
						markup += ' title="' + title + '"';
					}
					if(h){
						markup += ' height="' + h + '"';
					}
					if(w){
						markup += ' width="' + w + '"';
					}
					
					if(res == 1){
						markup += ' class="img-responsive"';
					}
					
					if(float){
						if(!linkURL){
							markup += ' style="float: ' + float + '"';
						}
					}
					
					markup += ' />';
					
					if(linkURL){
						var thelink = '<a href="' + linkURL + '"';
						
						if(target){
							thelink += ' target="' + target + '"';
						}
						
						if(float){
							thelink += ' style="float: ' + float + '"';
						}
						
						thelink += '>';
						markup = thelink + markup + '</a>';
					}
				
					editor.insertContent(markup);
				}
			}
		}

		win3 = editor.windowManager.open({
			title: "Manage Image (BVN)",
			width : 1024,
			height : 475,
			html: GetTheHtml(),
			buttons: [
				{
				text: 'Insert Image',
				subtype: 'primary',
				onclick: function(e) {
					BuildDom(document.getElementById("src").value, 
							document.getElementById("alt").value, 
							document.getElementById("width").value, 
							document.getElementById("height").value, 
							document.getElementById("title").value,
							document.getElementById("linkURL").value,
							document.getElementById("target").value,
							document.getElementById("align").value,
							document.getElementById("responsive").value);
					this.parent().parent().close();
				}
				},	
				{
				text: 'Cancel',
				onclick: function() {
					this.parent().parent().close();
				}
			}]
		});
	}
	
	editor.addButton('image', {
		icon: 'image',
		tooltip: 'Insert/edit image',
		onclick: showDialog,
		stateSelector: 'img:not([data-mce-object])'
	});

	editor.addMenuItem('image', {
		icon: 'image',
		text: 'Insert image',
		onclick: showDialog,
		context: 'insert',
		prependToContext: true
	});
});
