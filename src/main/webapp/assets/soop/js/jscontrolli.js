function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}

function getconsonants(str) {
    return str.replace(/[^BCDFGHJKLMNPQRSTVWXYZ]/gi, '');
}

function getvocal(str) {
    return str.replace(/[^AEIOU]/gi, '');
}

function specialchar(fieldid) {
    var stringToReplace = document.getElementById(fieldid).value;
    var specialChars = "~`'k§!#$%^&*+=-_[];,/{}|\":<>?£,.àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ°";
    for (var i = 0; i < specialChars.length; i++) {
        stringToReplace = stringToReplace.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
    }
    stringToReplace = stringToReplace.replace(/\\/g, "");
    stringToReplace = stringToReplace.replace(new RegExp("[0-9]", "g"), "");
    document.getElementById(fieldid).value = stringToReplace;

}
function specialchar2(fieldid) {
    var stringToReplace = document.getElementById(fieldid).value;
    var specialChars = "~`'k€§!#$%^&*+=-_[];,/{}|\":<>?£,.àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ°";
    for (var i = 0; i < specialChars.length; i++) {
        stringToReplace = stringToReplace.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
    }
    stringToReplace = stringToReplace.replace(/\\/g, "");
    // stringToReplace = stringToReplace.replace(new RegExp("[0-9]", "g"), "");
    document.getElementById(fieldid).value = stringToReplace;

}


function fieldNoEuro(fieldid) {

    var stringToReplace = document.getElementById(fieldid).value;
    var specialChars = "~`§!#$%^&*+=_@[]{}|\"<>?£âãäëîïñôõö€ûüýÿÀÁÂÃÄÇçÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ°";
    for (var i = 0; i < specialChars.length; i++) {
        stringToReplace = stringToReplace.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
    }
    stringToReplace = stringToReplace.replace(/\\/g, "");

    //  var stringToReplace = document.getElementById(fieldid).value;
    //  alert(stringToReplace);                
    // stringToReplace = stringToReplace.replace("€", '');
    document.getElementById(fieldid).value = stringToReplace;

}


function fieldNoEuroMail(fieldid) {

    var stringToReplace = document.getElementById(fieldid).value;
    var specialChars = "~`§!#$%^&*+€=[](){}|\"<>?£âãäëîïñôõö€ûüýÿÀÁÂÃÄÇçÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ°";
    for (var i = 0; i < specialChars.length; i++) {
        stringToReplace = stringToReplace.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
    }
    stringToReplace = stringToReplace.replace(/\\/g, "");

    //  var stringToReplace = document.getElementById(fieldid).value;
    //  alert(stringToReplace);                
    // stringToReplace = stringToReplace.replace("€", '');
    document.getElementById(fieldid).value = stringToReplace;

}


function getStringName(name) {
    var codname = getconsonants(name);
    if (codname.length >= 4) {
        codname = codname.charAt(0) + codname.charAt(2) + codname.charAt(3);
    } else {
        codname += getvocal(name);
        codname += 'XXX';
        codname = codname.substr(0, 3);
    }
    return codname.toUpperCase();
}

function getStringSurname(surname) {
    var codesurn = getconsonants(surname);
    codesurn += getvocal(surname);
    codesurn += 'XXX';
    codesurn = codesurn.substr(0, 3);
    return codesurn.toUpperCase();
}


function checkCF(cf) {
    var esito = true;
    var validi, i, s, set1, set2, setpari, setdisp;
    if (cf === '')
        esito = false;
    cf = cf.toUpperCase();
    if (cf.length === 16) {
        if (cf.length !== 16) {
            esito = false;
        } else {
            validi = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            for (i = 0; i < 16; i++) {
                if (validi.indexOf(cf.charAt(i)) === -1)
                    esito = false;
            }
            set1 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            set2 = "ABCDEFGHIJABCDEFGHIJKLMNOPQRSTUVWXYZ";
            setpari = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            setdisp = "BAKPLCQDREVOSFTGUHMINJWZYX";
            s = 0;
            for (i = 1; i <= 13; i += 2)
                s += setpari.indexOf(set2.charAt(set1.indexOf(cf.charAt(i))));
            for (i = 0; i <= 14; i += 2)
                s += setdisp.indexOf(set2.charAt(set1.indexOf(cf.charAt(i))));
            if (s % 26 !== cf.charCodeAt(15) - 'A'.charCodeAt(0)) {
                esito = false;
            }
            return esito;
        }
    } else {
        return false;
    }
}

function checkMail(mail) {
    return mail.includes("@");
//                var filter = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;
//                return filter.test(mail);
}

function checkIva(pi) {
    var esito = true;
    var validi, i, s, c;
    if (pi.length !== 11) {
        esito = false;
    } else {
        validi = "0123456789";
        for (i = 2; i < 11; i++) {
            if (validi.indexOf(pi.charAt(i)) === -1)
                esito = false;
        }
        s = 0;
        for (i = 0; i <= 9; i += 2)
            s += pi.charCodeAt(i) - '0'.charCodeAt(0);
        for (i = 1; i <= 9; i += 2) {
            c = 2 * (pi.charCodeAt(i) - '0'.charCodeAt(0));
            if (c > 9)
                c = c - 9;
            s += c;
        }
        if ((10 - s % 10) % 10 !== pi.charCodeAt(10) - '0'.charCodeAt(0))
            esito = false;
    }
    return esito;
}

function checkDate(dt) {
    var re = /^\d{1,2}\/\d{1,2}\/\d{4}$/;
    return dt.match(re);
}

function dismiss(name) {
    document.getElementById(name).className = "modal fade";
    document.getElementById(name).style.display = "none";
}

function containsNumeric(val) {
    var matches = val.match(/\d+/g);
    return matches !== null;
}

function containsSpecial(val) {
    var specialChars = "<>@!#$%^&*()_+[]{}?:;|'\"\\,./~`-=";
    for (var i = 0; i < specialChars.length; i++) {
        if (val.indexOf(specialChars[i]) > -1) {
            return true;
        }
    }
    return false;
}


function parseIntRaf(valueint) {
    valueint = valueint + "";
    valueint = valueint.replace(/\./g, '');
    valueint = valueint.replace(/,/g, '');
    return parseInt(valueint);
}
function parseFloatRaf(valuefloat) {
    if (valuefloat.indexOf(",") > -1) {
        valuefloat = valuefloat.replace(/\./g, '');
        valuefloat = valuefloat.replace(/,/g, '.');
    } else {
        if (valuefloat.indexOf(".") === -1) {
            valuefloat = valuefloat + ".00";
        }
    }
    return parseFloat(valuefloat);
}


function formatDouble(fieldid) {
    document.getElementById(fieldid).value = accounting.formatNumber(parseFloatRaf(document.getElementById(fieldid).value), 2, ".", ",");
}
function fieldOnlyNumber(fieldid) {
    var stringToReplace = document.getElementById(fieldid).value;
    stringToReplace = stringToReplace.replace(/\D/g, '');
    document.getElementById(fieldid).value = stringToReplace;
}

function formatDoubleMax(fieldid, max) {
    if (parseFloatRaf(document.getElementById(fieldid).value) >= parseFloatRaf(max)) {
        document.getElementById(fieldid).value = max;
    }
    document.getElementById(fieldid).value = accounting.formatNumber(parseFloatRaf(document.getElementById(fieldid).value), 2, ".", ",");
}

function getMesecf(read) {
    read = read.trim().toUpperCase();
    if (read === "A") {
        return "01";
    }
    if (read === "B") {
        return "02";
    }
    if (read === "C") {
        return "03";
    }
    if (read === "D") {
        return "04";
    }
    if (read === "E") {
        return "05";
    }
    if (read === "H") {
        return "06";
    }
    if (read === "L") {
        return "07";
    }
    if (read === "M") {
        return "08";
    }
    if (read === "P") {
        return "09";
    }
    if (read === "R") {
        return "10";
    }
    if (read === "S") {
        return "11";
    }
    if (read === "T") {
        return "12";
    }
    return "00";
}

function controllaCF_completo(CF1, Nome1, Cognome1, Datanascita1, Sesso1, ComuneCF1, indice) {

    var msg = "";

    var giorno = Datanascita1.split("/")[0];
    var mese = Datanascita1.split("/")[1];
    var anno = Datanascita1.split("/")[2].substring(2);
    
    var cf_giorno = CF1.substring(9, 11);
    var cf_mese = getMesecf(CF1.substring(8, 9));
    var cf_anno = CF1.substring(6, 8);
    var cf_sesso = "";
    if (cf_giorno < 32) {
        cf_sesso = "M";
    } else if (cf_giorno > 40) {
        cf_sesso = "F";
        cf_giorno = cf_giorno - 40;
        if (cf_giorno < 10) {
            cf_giorno = "0" + cf_giorno;
        }
    }

    console.log(giorno + " -- " + cf_giorno);
    console.log(mese + " -- " + cf_mese);
    console.log(anno + " -- " + cf_anno);

    if (parseIntRaf(giorno) !== parseIntRaf(cf_giorno) || parseIntRaf(mese) !== parseIntRaf(cf_mese) || parseIntRaf(anno) !== parseIntRaf(cf_anno)) {
        msg += "<span style='color:red;'>Sezione Docente " + indice + ". Il campo 'Codice Fiscale' non &#232; coerente con quanto inserito nel campo 'Data di Nascita'.</span><br/>";
    }

    if (Sesso1 !== cf_sesso) {
        msg += "<span style='color:red;'>Sezione Docente " + indice + ". Il campo 'Codice Fiscale' non &#232; coerente con quanto inserito nel campo 'Sesso'.</span><br/>";
    }

    var checksurname = getStringSurname(Cognome1);
    var checkname = getStringName(Nome1);

    if (checksurname !== 'XXX') {
        if (CF1.substring(0, 3) !== checksurname) {
            msg += "<span style='color:red;'>Sezione Docente " + indice + ". Il campo 'Codice Fiscale' non &#232; coerente con quanto inserito nel campo 'Cognome'.</span><br/>";
        }
    }
    if (checkname !== 'XXX') {
        if (CF1.substring(3, 6) !== checkname) {
            msg += "<span style='color:red;'>Sezione Docente " + indice + ". Il campo 'Codice Fiscale' non &#232; coerente con quanto inserito nel campo 'Nome'.</span><br/>";
        }
    }
    if (CF1.substring(11, 15) !== ComuneCF1) {
        msg += "<span style='color:red;'>Sezione Docente " + indice + ". Il campo 'Codice Fiscale' non &#232; coerente con quanto inserito nel campo 'Comune di Nascita'.</span><br/>";
    }
    return msg;
}

function controllaCF_delegato(CF1, Nome1, Cognome1, Datanascita1, Sesso1, ComuneCF1, indice) {

    var msg = "";

    var giorno = Datanascita1.split("/")[0];
    var mese = Datanascita1.split("/")[1];
    var anno = Datanascita1.split("/")[2].substring(2);

    var cf_giorno = CF1.substring(9, 11);
    var cf_mese = getMesecf(CF1.substring(8, 9));
    var cf_anno = CF1.substring(6, 8);
    var cf_sesso = "";
    if (cf_giorno < 32) {
        cf_sesso = "M";
    } else if (cf_giorno > 40) {
        cf_sesso = "F";
        cf_giorno = cf_giorno - 40;
        if (cf_giorno < 10) {
            cf_giorno = "0" + cf_giorno;
        }
    }

    if (parseIntRaf(giorno) !== parseIntRaf(cf_giorno) || parseIntRaf(mese) !== parseIntRaf(cf_mese) || parseIntRaf(anno) !== parseIntRaf(cf_anno)) {
        msg += "Soggetto Delegato " + indice + ". Il campo <b style='color:red;'>Codice Fiscale'</b> non &#232; coerente con quanto inserito nel campo 'Data di Nascita'.<br/>";
    }

    if (Sesso1 !== cf_sesso) {
        msg += "Soggetto Delegato " + indice + ". Il campo <b style='color:red;'>Codice Fiscale'</b> non &#232; coerente con quanto inserito nel campo 'Sesso'.<br/>";
    }

    var checksurname = getStringSurname(Cognome1);
    var checkname = getStringName(Nome1);

    if (checksurname !== 'XXX') {
        if (CF1.substring(0, 3) !== checksurname) {
            msg += "Soggetto Delegato " + indice + ". Il campo <b style='color:red;'>Codice Fiscale'</b> non &#232; coerente con quanto inserito nel campo 'Cognome'.<br/>";
        }
    }
    if (checkname !== 'XXX') {
        if (CF1.substring(3, 6) !== checkname) {
            msg += "Soggetto Delegato " + indice + ". Il campo <b style='color:red;'>Codice Fiscale'</b> non &#232; coerente con quanto inserito nel campo 'Nome'.<br/>";
        }
    }
    if (CF1.substring(11, 15) !== ComuneCF1) {
        msg += "Soggetto Delegato " + indice + ". Il campo <b style='color:red;'>Codice Fiscale'</b> non &#232; coerente con quanto inserito nel campo 'Comune di Nascita'.<br/>";
    }
    return msg;
}

function setperiodo(iddate) {
    var newid = iddate.replace("da", "a");
    var currentDate = $("#" + iddate).datepicker("getDate");
    $('#' + newid).val("");
    $('#' + newid).datepicker('remove');
    if (currentDate === null || currentDate === "") {

    } else {
        $('#' + newid).datepicker({
            rtl: App.isRTL(),
            orientation: "left",
            autoclose: true,
            startDate: currentDate,
            endDate: new Date()
        });
    }
}

function disable_sel2(id, idform) {
    var $dropDown = $('#' + id), name = id,
            $form = $dropDown.parent('form');
    $dropDown.data('original-name', name);
    $('#' + idform).find('input[type="hidden"][name=' + name + ']').remove();
    $('#' + idform).append('<input type="hidden" name="' + name + '" value="' + $dropDown.val() + '" />');
    $dropDown.addClass('disabled').prop({name: name + "_r", disabled: true});
}

function enable_sel2(id, idform) {
    var $dropDown = $('#' + id), name = id, $form = $dropDown.parent('form');
    $dropDown.data('original-name', name);
    $("input[type='hidden'][name=" + name + "]").remove();
    $form.find('input[type="hidden"][name=' + name + ']').remove();
    $dropDown.removeClass('disabled').prop({name: name, disabled: false});
}

//IBAN
function checkIBAN(input) {

    var controllare = input.value.trim();

    var CODE_LENGTHS = {
        AD: 24, AE: 23, AT: 20, AZ: 28, BA: 20, BE: 16, BG: 22, BH: 22, BR: 29,
        CH: 21, CR: 21, CY: 28, CZ: 24, DE: 22, DK: 18, DO: 28, EE: 20, ES: 24,
        FI: 18, FO: 18, FR: 27, GB: 22, GI: 23, GL: 18, GR: 27, GT: 28, HR: 21,
        HU: 28, IE: 22, IL: 23, IS: 26, IT: 27, JO: 30, KW: 30, KZ: 20, LB: 28,
        LI: 21, LT: 20, LU: 20, LV: 21, MC: 27, MD: 24, ME: 22, MK: 19, MR: 27,
        MT: 31, MU: 30, NL: 18, NO: 15, PK: 24, PL: 28, PS: 29, PT: 25, QA: 29,
        RO: 24, RS: 22, SA: 24, SE: 24, SI: 19, SK: 24, SM: 27, TN: 24, TR: 26
    };
    var iban = String(controllare).toUpperCase().replace(/[^A-Z0-9]/g, ''), // keep only alphanumeric characters
            code = iban.match(/^([A-Z]{2})(\d{2})([A-Z\d]+)$/), // match and capture (1) the country code, (2) the check digits, and (3) the rest
            digits;
    // check syntax and length
    if (!code || iban.length !== CODE_LENGTHS[code[1]]) {
        return false;
    }
    // rearrange country code and check digits, and convert chars to ints
    digits = (code[3] + code[1] + code[2]).replace(/[A-Z]/g, function (letter) {
        return letter.charCodeAt(0) - 55;
    });
    // final check
    var es1 = mod97(digits);
    return (es1 === 1 || es1 === "1");
}

function mod97(string) {
    var checksum = string.slice(0, 2), fragment;
    for (var offset = 2; offset < string.length; offset += 7) {
        fragment = String(checksum) + string.substring(offset, offset + 7);
        checksum = parseInt(fragment, 10) % 97;
    }
    return checksum;
}