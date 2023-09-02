let isKey = false;
let isBox = false;
let isPaper = false;
let isLamp = false;
let isLetter = false;

function bup() {
    if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 2) {
        $('#space1').animate({
            width: 0
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h1();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 22 && $('#space2').width() >= 18) {
        $('#space1').animate({
            width: 20
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h1();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 42 && $('#space2').width() >= 38) {
        $('#space1').animate({
            width: 40
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h1();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 62 && $('#space2').width() >= 58 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h2();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 62 && $('#space2').width() >= 58 && $('#space3').width() <= 22 && $('#space3').width() >= 18) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 20
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h2();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 62 && $('#space2').width() >= 58 && $('#space3').width() <= 42 && $('#space3').width() >= 38) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 40
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h2();
    } else return;
}

function bdown() {
    if ($('#space1').width() <= 2 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h2();
    } else if ($('#space1').width() <= 22 && $('#space1').width() >= 18 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 20
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h2();
    } else if ($('#space1').width() <= 42 && $('#space1').width() >= 38 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 40
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h2();
    } else if ($('#space1').width() >= 58 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 60
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        h3();
    } else if ($('#space1').width() >= 58 && $('#space2').width() <= 22 && $('#space2').width() >= 18 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 60
        }, 0);
        $('#space3').animate({
            width: 20
        }, 0);
        h3();
    } else if ($('#space1').width() >= 58 && $('#space2').width() <= 42 && $('#space2').width() >= 38 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 60
        }, 0);
        $('#space3').animate({
            width: 40
        }, 0);
        h3();
    } else return;
}

function bleft() {
    if ($('#space1').width() <= 22 && $('#space1').width() >= 18 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 0
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v1();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 22 && $('#space2').width() >= 18 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v1();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 62 && $('#space2').width() >= 58 && $('#space3').width() <= 22 && $('#space3').width() >= 18) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 60
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v1();
    } else if ($('#space1').width() <= 42 && $('#space1').width() >= 38 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 20
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v2();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 42 && $('#space2').width() >= 38 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 20
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v2();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 62 && $('#space2').width() >= 58 && $('#space3').width() <= 42 && $('#space3').width() >= 38) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 60
        }, 0);
        $('#space3').animate({
            width: 20
        }, 0);
        v2();
    } else return;
}

function bright() {
    if ($('#space1').width() <= 2 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 20
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v2();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 20
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v2();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 62 && $('#space2').width() >= 58 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 60
        }, 0);
        $('#space3').animate({
            width: 20
        }, 0);
        v2();
    } else if ($('#space1').width() <= 22 && $('#space1').width() >= 18 && $('#space2').width() <= 2 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 40
        }, 0);
        $('#space2').animate({
            width: 0
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v3();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 22 && $('#space2').width() >= 18 && $('#space3').width() <= 2) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 40
        }, 0);
        $('#space3').animate({
            width: 0
        }, 0);
        v3();
    } else if ($('#space1').width() <= 62 && $('#space1').width() >= 58 && $('#space2').width() <= 62 && $('#space2').width() >= 58 && $('#space3').width() <= 22 && $('#space3').width() >= 18) {
        $('#space1').animate({
            width: 60
        }, 0);
        $('#space2').animate({
            width: 60
        }, 0);
        $('#space3').animate({
            width: 40
        }, 0);
        v3();
    } else return;
}

function v1() {
    $('#back').animate({
        marginLeft: 0
    }, 500);
}

function v2() {
    $('#back').animate({
        marginLeft: -535
    }, 500);
}

function v3() {
    $('#back').animate({
        marginLeft: -1070
    }, 500);
}

function h1() {
    $('#back').animate({
        marginTop: 0
    }, 500);
}

function h2() {
    $('#back').animate({
        marginTop: -330
    }, 500);
}

function h3() {
    $('#back').animate({
        marginTop: -660
    }, 500);
}
// ALEX 
function key() {
    $('#smallKey').hide();
    $('.speech').hide(0);
    $('#spcKey').show(0);
    keyItem();
    $('#inv1').animate({
        width: 81
    }, 0);
    isKey = true;
}

function keyItem() {
    $('#boxBox').hide();
    $('#paperBox').hide();
    $('#letterBox').hide();
    $('#lampBox').hide();
    $('#docBox').hide();
    $('#zoom').hide(0);
    $('#zoom').fadeIn(500);
    $('#keybox').show(0);
}

function box() {
    $('#smallBox').hide();
    $('.speech').hide(0);
    $('#spcBox').show(0);
    boxItem();
    $('#inv2').animate({
        width: 81
    }, 0);
    isBox = true;
}

function boxItem() {
    $('#keybox').hide();
    $('#paperBox').hide();
    $('#letterBox').hide();
    $('#lampBox').hide();
    $('#docBox').hide();
    $('#zoom').hide(0);
    $('#zoom').fadeIn(500);
    $('#boxBox').show(0);
}
// END ALEX

// EMILY
function paper() {
    $('#smallPaper').hide();
    $('.speech').hide(0);
    $('#spcPaper').show(0);
    paperItem();
    $('#inv3').animate({
        width: 81
    }, 0);
    isPaper = true;
}

function paperItem() {
    $('#keybox').hide();
    $('#boxBox').hide();
    $('#letterBox').hide();
    $('#lampBox').hide();
    $('#docBox').hide();
    $('#zoom').hide(0);
    $('#zoom').fadeIn(500);
    $('#paperBox').show();
}
// END EMILY

// CAREN
function lamp() {
    $('#smallLamp').hide();
    $('.speech').hide(0);
    $('#spcLamp').show(0);
    lampItem();
    $('#inv4').animate({
        width: 81
    }, 0);
    isLamp = true;
}

function lampItem() {
    $('#keybox').hide();
    $('#boxBox').hide();
    $('#letterBox').hide();
    $('#paperBox').hide();
    $('#docBox').hide();
    $('#zoom').hide(0);
    $('#zoom').fadeIn(500);
    $('#lampBox').show();
}

function letter() {
    $('#smallLetter').hide();
    $('.speech').hide(0);
    $('#spcLetter').show(0);
    letterItem();
    $('#inv5').animate({
        width: 81
    }, 0);
    isLetter = true;
}

function letterItem() {
    $('#keybox').hide();
    $('#boxBox').hide();
    $('#lampBox').hide();
    $('#paperBox').hide();
    $('#docBox').hide();
    $('#zoom').hide(0);
    $('#zoom').fadeIn(500);
    $('#letterBox').show();
}
// END CAREN

function docItem() {
	$('#keybox').hide();
    $('#boxBox').hide();
    $('#lampBox').hide();
    $('#paperBox').hide();
    $('#letterBox').hide();
    $('#zoom').hide(0);
    $('#zoom').fadeIn(500);
    $('#docBox').show();
}

function hint() {
    $('#hinter').toggle(300);
}

function hindel() {
    $('#hinter').hide(300);
}

function clr1() {
    $('.speech').hide(0);
}

function falsedel(){
   $('#closeFalse').hide(0);
}

function XClick(name){
    let itemCheck = false;

    switch(name){
        case "alex" :
            if(isKey && isBox) itemCheck = true;
        break;

        case "emily" :
            if(isPaper) itemCheck = true;
        break;
        
        case "caren" :
            if(isLamp && isLetter) itemCheck = true;
        break;
    }

    if(itemCheck) {
        document.getElementById('closeTrue').style.display = 'block';
        document.getElementById('close').style.display = 'none';
    }else{
        if(document.getElementById('closeFalse').style.display == 'block'){
            document.getElementById('closeFalse').style.display = 'none';
        }else{
            document.getElementById('closeFalse').style.display = 'block';
        }
    }
}

function findEnd(){
    findEnding();
}