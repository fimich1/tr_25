// серверная часть treiner_id made by F
function doPost(request){
        //  var tr_id = parseInt(request.parameter.tr_id);  // Open Google Sheet using ID
        var tr_id = request.parameter.tr_id;
        var ids = request.parameter.id;
        var name = request.parameter.name;
        // var tr_id = request.parametr.tr_id;
        //var tr_id = 0;

        var noon = new Date();
        var timeZone = SpreadsheetApp.getActive().getSpreadsheetTimeZone();
        var now = Utilities.formatDate(noon, timeZone, 'dd.MM.yyyy');

        var ss = SpreadsheetApp.openById("1VaCsi_Cw5CP0ULcOLIatbSfWOsjx23mdUUGaOmBQIAk");

        var noon = new Date();
        var timeZone = SpreadsheetApp.getActive().getSpreadsheetTimeZone();
        var now = Utilities.formatDate(noon, timeZone, 'dd.MM.yyyy');


//   var ss = SpreadsheetApp.getActiveSpreadsheet();
//var sheet = ss.getSheets()[1];


//    var sheetsList = ss.getSheets();
//     var sheet = sheetsList[1];
//   var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(ids);
// var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('futbol');
        // = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("Robin");
        var sheet = ss.getSheetByName(ids);
// var sheet = ss.getSheets()[1];   // в скобках - код тренера

        var arrData = sheet.getRange(1, 1, sheet.getLastRow(),sheet.getLastColumn()+1).getDisplayValues()

        for(var row = 0; row<arrData.length; row++){
        for(var col = 0; col<arrData[0].length; col++){
        if(arrData[row][col] == name){
        var rrow = getLastColNum(row+1);
        var last = sheet.getRange(row+1,rrow).getDisplayValues();
        if (now.toString() != last.toString()) {
        sheet.getRange(row+1,rrow+1).setValue(now);}
        }
        }
        }


        var result = {"status": "SUCCESS"};
        try{
        // Get all Parameters
//    var name = request.parameter.name;   -перенес наверх функции
//    var unit = request.parameter.unit;
//    var id = request.parameter.id;
//    var rowData = sheet.appendRow([name, unit, id]);   // пишем новую строку


        }catch(exc){
        // If error occurs, throw exception
        result = {"status": "FAILED", "message": exc};
        }

        // Return result
        return ContentService
        .createTextOutput(JSON.stringify(result))
        .setMimeType(ContentService.MimeType.JSON);
        }



//const doGet = (event = {}) => {
//  const { parameter } = event;
//  const { name = 'Anonymous', country = 'Unknown' } = parameter;
//  const output = `Hello ${name} from ${country}`;
//  return ContentService.createTextOutput(output);
//};
//
//?name=Amit&country=India
//https://www.labnol.org/code/19871-get-post-requests-google-script


        function doGet(e){
        var sheet = SpreadsheetApp.openById("1VaCsi_Cw5CP0ULcOLIatbSfWOsjx23mdUUGaOmBQIAk");


//function doGet(e) {
        var id = e.parameter.id; // fetches parameters

//  var url = createDocument(invoice_id, digits); // url should be a list here
//  return (url[0], ContentService.createTextOutput(url[1])); //Should have returned the listOfNums and the document here
//}




        // Get all values in active sheet
        //var values = sheet.getActiveSheet().getDataRange().getValues();
        // https://developers.google.com/apps-script/reference/spreadsheet/spreadsheet?hl=en#getnumsheets
        // Logger.log(SpreadsheetApp.getActiveSpreadsheet().getNumSheets());
        // getNumSheets());



        var values = sheet.getSheetByName(id).getDataRange().getValues();

        var data = [];

        for (var i = values.length - 2; i >= 0; i--) {

        var row = values[i];

        var feedback = {};

        feedback['name'] = row[0];
        feedback['unit'] = row[1];
        feedback['id'] = row[2];

        data.push(feedback);
        }
        return ContentService
        .createTextOutput(JSON.stringify(data))
        .setMimeType(ContentService.MimeType.JSON);
        }

//вспомогательные функции

// function getLastColNum(rowToCheck) {
// //function getLastNonEmptyCellInRow() {
//  // var rowToCheck = 2;

//   var ss = SpreadsheetApp.getActiveSpreadsheet();
//   var sheet = ss.getActiveSheet();

//   var maxColumns = sheet.getLastRow();

//   var rowData = sheet.getRange(rowToCheck, 1, 1, maxColumns).getValues();
//   rowData = rowData[0]; //Get inner array of two dimensional array


//  var rowLength = rowData.length;

//   for (var i = 0; i < rowLength; i++) {
//     var thisCellContents = getLastColNum(rowData[i]);

//     Logger.log('thisCellContents: ' + thisCellContents);

//     if (thisCellContents === "") {
//       Logger.log(i);
//       return i + 3;  //Pass the count plus one, which is the last column with data
//     }
//   }
// }




        function getLastRowSpecial(rowNum){
        var rowNum = 0;
        var blank = false;
        for(var row = 0; row < range.length; row++){

        if(range[row][0] === "" && !blank){
        rowNum = row;
        blank = true;

        }else if(range[row][0] !== ""){
        blank = false;
        };
        };
        return rowNum;
        };

        function getLastColNum(rowNum)
        {

        // Get the values of the row's (unbounded by column number) range.
        var vals =
        SpreadsheetApp.getActiveSpreadsheet().getActiveSheet()
        .getRange(rowNum +":"+ rowNum)
        .getValues()[0],

        lastColNum = vals.length
        ;

        // Decrement while popping off any trailing empty text ("") cells.
        while(!vals.pop())
        { --lastColNum; }


        return(lastColNum);
        }






        function onOpen()
        {
        // Создаём новое меню
        // https://developers.google.com/apps-script/reference/base/ui#createmenucaption
        SpreadsheetApp.getUi()
        .createMenu('НАЧФИЗ ПКУ')
        .addItem('Отчет за неделю', 'myFunction1')
        .addSeparator()
        .addSubMenu(SpreadsheetApp.getUi().createMenu('Подменю')
        .addItem('Отчет за вид спорта', 'myFunction2')
        .addItem('Отчет за месяц', 'myFunction3'))
        .addSeparator()
        .addItem('Отчет по взводу', 'myFunction4')
        .addToUi();

        // myFunction1, myFunction2, myFunction3 - функции, которые вызываются при нажатии на элемент меню


        // Добавляем новые пункты в меню "Дополнения"
        // https://developers.google.com/apps-script/reference/base/ui#createaddonmenu
        SpreadsheetApp.getUi()
        .createAddonMenu()
        .addItem('Открыть сайдбар', 'openSidebar')
        .addItem('Открыть модальное окно', 'openModal')
        .addToUi();

        // 'Открыть сайдбар' - название пункта меню
        // 'openSidebar' - функция, которая сработает при нажатии на этот пункт
        }


        function Myindexof(s,text)
        {
        var lengths = s.length;
        var lengtht = text.length;
        for (var i = 0;i < lengths - lengtht + 1;i++)
        {
        if (s.substring(i,lengtht + i) == text)
        return i;
        }
        return -1;
        }


