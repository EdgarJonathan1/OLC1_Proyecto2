var contador = 0;
var contenidoAST = "";
var host = "http://192.168.1.13:8080/Ana/"
//var host = "http://172.17.0.2:8080/Ana/"

function get_cont() {
    return contador++;
}

var vent_focus = "pestana1";

function get_vent() {
    return vent_focus;
}

function set_vent(vent) {
    vent_focus = vent;
}

var lista = new Array();

function linkedlist(pestana, nombre) {
    var obj = new Object();
    obj.pestana = pestana;
    obj.nombre = nombre;
    lista.push(obj);
}

/*-------------------------------------------------------------------------------------------------------*/
/*--------------------------------------Funcion Al Cambiar Ventana---------------------------------------*/
/*-------------------------------------------------------------------------------------------------------*/

function index(pestanias, pestania) {
    var id = pestania.replace('pestana', '');
    set_vent('textarea' + id);

    var pestanna1 = document.getElementById(pestania);
    var listaPestannas = document.getElementById(pestanias);
    var cpestanna = document.getElementById('c' + pestania);
    var listacPestannas = document.getElementById('contenido' + pestanias);

    var i = 0;
    while (typeof listacPestannas.getElementsByTagName('div')[i] != 'undefined') {
        $(document).ready(function () {
            $(listacPestannas.getElementsByTagName('div')[i]).css('display', 'none');
            $(listaPestannas.getElementsByTagName('li')[i]).css('background', '');
            $(listaPestannas.getElementsByTagName('li')[i]).css('padding-bottom', '');
        });
        i += 1;
    }

    $(document).ready(function () {
        $(cpestanna).css('display', '');
        $(pestanna1).css('background', 'dimgray');
        $(pestanna1).css('padding-bottom', '2px');
    });

    try {
        var act = document.getElementById('cpestana' + id);
        var tact = document.getElementById('textarea' + id);

        while (act.firstChild) {
            act.removeChild(act.firstChild);
        }

        act.appendChild(tact);
        var editor = CodeMirror(act, {
            lineNumbers: true,
            value: tact.value,
            matchBrackets: true,
            styleActiveLine: true,
            theme: "eclipse",
            mode: "text/x-java"
        }).on('change', editor => {
            tact.value = editor.getValue();
        });
    } catch (error) { }
}

function add_tab() {
    var x = get_cont();
    var lista_pestañas = document.getElementById("lista_pestanas");
    var li = document.createElement("li");
    li.setAttribute('id', 'pestana' + x);
    var a = document.createElement("a");
    a.setAttribute('id', 'a' + x);
    a.setAttribute('href', 'javascript:index("pestanas","pestana' + x + '")');
    a.text = 'pestana' + x;
    li.appendChild(a);
    lista_pestañas.appendChild(li);
    index("pestanas", "pestana" + x);

    var contenido = document.getElementById("contenidopestanas");
    var divp = document.createElement("div");
    divp.setAttribute('id', 'cpestana' + x);
    var ta = document.createElement("textarea");
    ta.setAttribute('id', 'textarea' + x);
    ta.setAttribute('name', 'textarea' + x);
    ta.setAttribute('class', 'ta');
    ta.setAttribute('style', 'display:none');
    ta.cols = 123;
    ta.rows = 30;
    divp.appendChild(ta);
    contenido.appendChild(divp);

    var act = document.getElementById('cpestana' + x);
    var tact = document.getElementById('textarea' + x);
    var editor = CodeMirror(act, {
        lineNumbers: true,
        value: tact.value,
        matchBrackets: true,
        styleActiveLine: true,
        theme: "eclipse",
        mode: "text/x-java"
    }).on('change', editor => {
        tact.value = editor.getValue();
    });
}

/*------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------File---------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
function AbrirArchivo(files) {
    var file = files[0];
    var reader = new FileReader();
    reader.onload = function (e) {
        var act = document.getElementById(get_vent().replace("textarea", "cpestana"));
        var tact = document.getElementById(get_vent());
        tact.value = e.target.result;

        while (act.firstChild) {
            act.removeChild(act.firstChild);
        }

        act.appendChild(tact);
        var editor = CodeMirror(act, {
            lineNumbers: true,
            value: tact.value,
            matchBrackets: true,
            styleActiveLine: true,
            theme: "eclipse",
            mode: "text/x-java"
        }).on('change', editor => {
            tact.value = editor.getValue();
        });
    };
    reader.readAsText(file);
    file.clear;

    var a = document.getElementById(get_vent().replace("textarea", "a"));
    a.text = file.name;
    linkedlist(get_vent(), file.name);

    var file_input = document.getElementById("fileInput");
    document.getElementById('fileInput').value = "";
}

/*------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------ComunicacionApi---------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
function hacerPost() {

    var ta = document.getElementById(get_vent());
    var contenido = ta.value;
    contenido = contenido.replace(/\"/gm, '\'');
    contenido = contenido.replace(/\\\'/gm, '');


    var enviar = {
        texto: contenido
    };

    var data = new FormData();
    data.append("json", JSON.stringify(enviar));
    //console.log("enviando: " + JSON.stringify(enviar))   

    fetch(host + "Javascript", {
        method: "POST",
        headers: {
            'Accept': 'application/json, application/json, */*',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(enviar)
    })
        .then(res => res.json())
        .then(data => {
            console.log(data.responde);


            var ReportError = document.getElementById('tablaError');
            var consoleJava = document.getElementById('consoleJavascript');
            var tablaToken = document.getElementById('tablaToken');

            while (ReportError.firstChild) { ReportError.removeChild(ReportError.firstChild); }
            while (consoleJava.firstChild) { consoleJava.removeChild(consoleJava.firstChild); }
            while (tablaToken.firstChild) { tablaToken.removeChild(tablaToken.firstChild); }


            ReportError.innerHTML = data.errores;
            consoleJava.innerHTML = data.consola;
            tablaToken.innerHTML = data.tokens;
        }
        )

}

function DescargarJavascript() {
    var ta = document.getElementById(get_vent());
    var contenido = ta.value;
    contenido = contenido.replace(/\"/gm, '\'');
    contenido = contenido.replace(/\\\'/gm, '');


    var enviar = {
        texto: contenido
    };

    var data = new FormData();
    data.append("json", JSON.stringify(enviar));
    //console.log("enviando: " + JSON.stringify(enviar))   

    fetch(host + "traducirJavascript", {
        method: "POST",
        headers: {
            'Accept': 'application/json, application/json, */*',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(enviar)
    })
        .then(res => res.json())
        .then(data => {
            console.log(data.responde);


            var contenido = data.traduccion; //texto de vent actual

            var nombre =  "Traduccion.java";
            var file = new Blob([contenido], { type: 'text/plain' });

            if (window.navigator.msSaveOrOpenBlob) {
                window.navigator.msSaveOrOpenBlob(file, nombre);
            } else {
                var a = document.createElement("a"),
                    url = URL.createObjectURL(file);
                a.href = url;
                a.download = nombre;
                document.body.appendChild(a);
                a.click();
                setTimeout(function () {
                    document.body.removeChild(a);
                    window.URL.revokeObjectURL(url);
                }, 0);
            }

        }
    )

}

function DescargarArchivo() {
    var ta = document.getElementById(get_vent());
    var contenido = ta.value; //texto de vent actual


    var nombre = get_vent().replace("textarea", "tab") + ".java";
    var file = new Blob([contenido], { type: 'text/plain' });

    if (window.navigator.msSaveOrOpenBlob) {
        window.navigator.msSaveOrOpenBlob(file, nombre);
    } else {
        var a = document.createElement("a"),
            url = URL.createObjectURL(file);
        a.href = url;
        a.download = nombre;
        document.body.appendChild(a);
        a.click();
        setTimeout(function () {
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);
        }, 0);
    }
}