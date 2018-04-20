<cfprocessingdirective pageEncoding="utf-8">

    <style type="text/css">
        #mynetwork {
            width: 840px;
            height: 600px;
            border: 1px solid lightgray;
        }
        /*#protectNetwork {
            position: absolute;
            left: 30px;
            top: 20px;
            filter:alpha(opacity=0);
            width:840px;
            height:600px;
            z-index: 1;
        }*/
        #loadingBar {
            position:absolute;
            top:20px;
            left:30px;
            width: 840px;
            height: 600px;
            background-color:rgba(200,200,200,0.8);
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -ms-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
            opacity:1;
        }
        #text {
            position:absolute;
            top:8px;
            left:530px;
            width:30px;
            height:50px;
            margin:auto auto auto auto;
            font-size:22px;
            color: #000000;
        }
        div.outerBorder {
            position:relative;
            top:400px;
            width:600px;
            height:44px;
            margin:auto auto auto auto;
            border:8px solid rgba(0,0,0,0.1);
            background: rgb(252,252,252); /* Old browsers */
            background: -moz-linear-gradient(top,  rgba(252,252,252,1) 0%, rgba(237,237,237,1) 100%); /* FF3.6+ */
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(252,252,252,1)), color-stop(100%,rgba(237,237,237,1))); /* Chrome,Safari4+ */
            background: -webkit-linear-gradient(top,  rgba(252,252,252,1) 0%,rgba(237,237,237,1) 100%); /* Chrome10+,Safari5.1+ */
            background: -o-linear-gradient(top,  rgba(252,252,252,1) 0%,rgba(237,237,237,1) 100%); /* Opera 11.10+ */
            background: -ms-linear-gradient(top,  rgba(252,252,252,1) 0%,rgba(237,237,237,1) 100%); /* IE10+ */
            background: linear-gradient(to bottom,  rgba(252,252,252,1) 0%,rgba(237,237,237,1) 100%); /* W3C */
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fcfcfc', endColorstr='#ededed',GradientType=0 ); /* IE6-9 */
            border-radius:72px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
        }
        #border {
            position:absolute;
            top:10px;
            left:10px;
            width:500px;
            height:23px;
            margin:auto auto auto auto;
            box-shadow: 0px 0px 4px rgba(0,0,0,0.2);
            border-radius:10px;
        }
        #bar {
            position:absolute;
            top:0px;
            left:0px;
            width:20px;
            height:20px;
            margin:auto auto auto auto;
            border-radius:11px;
            border:2px solid rgba(30,30,30,0.05);
            background: rgb(0, 173, 246); /* Old browsers */
            box-shadow: 2px 0px 4px rgba(0,0,0,0.4);
        }
    </style>

    <script type="text/javascript">

        // create some nodes
        var edges = [];
        var nodos1 = [];
        var nodes = [];
        <cfif isDefined('prc.rutas.recordCount')>
            <cfloop index='i' from='1' to='#prc.rutas.recordCount#'>
                <cfoutput>
                    edges.push({
                        from: #prc.rutas.NUMUNO[i]#,
                        to: #prc.rutas.NUMDOS[i]#,
                        arrows:'to',
                        label: "#prc.rutas.NOMROL[i]# - #prc.rutas.NOMACCION[i]#",
                        font: {align: 'horizontal'}
                    });
                    nodos1.push(#prc.rutas.NUMUNO[i]#);
                    nodos1.push(#prc.rutas.NUMDOS[i]#);
                </cfoutput>
            </cfloop>
        </cfif>

        var estados = nodos1.sort().filter(function(elem, pos) {
           return nodos1.indexOf(elem) == pos;
        });

        for(var i = 0; i < estados.length; i++){
        	var posx = i * 150;
        	var posy = i%2 * 200;
        	nodes.push({id:estados[i], x:posx, y:posy, label:'Estado '+ estados[i], color: {background:'rgb(217, 217, 217)', border:'rgb(127, 37, 84)'}});
        }

        // create a network
        var container = document.getElementById('mynetwork');
        var data = {nodes: nodes, edges: edges};

        var options = {
            physics:{
              enabled: true,
              repulsion: {
                centralGravity: 0.0,
                springConstant: 0.0,
                damping: 1
              },
              maxVelocity: 50,
              minVelocity: 0.1,
              solver: 'repulsion',
              stabilization: {
                enabled: true,
                iterations: 1000,
                updateInterval: 100,
                onlyDynamicEdges: false,
                fit: true
              },
              timestep: 0.5,
              adaptiveTimestep: true
            },
             //physics: false //Quita el rebote
        };

        var network = new vis.Network(container, data, options);

        network.on("stabilizationProgress", function(params) {
            var maxWidth = 496;
            var minWidth = 20;
            var widthFactor = params.iterations/params.total;
            var width = Math.max(minWidth,maxWidth * widthFactor);

            document.getElementById('bar').style.width = width + 'px';
            document.getElementById('text').innerHTML = Math.round(widthFactor*100) + '%';
        });
        network.once("stabilizationIterationsDone", function() {
            document.getElementById('text').innerHTML = '100%';
            document.getElementById('bar').style.width = '496px';
            document.getElementById('loadingBar').style.opacity = 0;
            // really clean the dom element
            setTimeout(function () {document.getElementById('loadingBar').style.display = 'none';}, 500);
        });

    </script>

<!--- <div id="protectNetwork"></div> --->
<div id="mynetwork"></div>

<div id="loadingBar">
    <div class="outerBorder">
        <div id="text">0%</div>
        <div id="border">
            <div id="bar"></div>
        </div>
    </div>
</div>
