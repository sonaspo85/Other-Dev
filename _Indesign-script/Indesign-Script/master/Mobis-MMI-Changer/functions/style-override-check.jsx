#target "InDesign";

$.localize = true;

$.locale = null;

//$.locale = "en";

function main() {

    

    //var redefineParagraphStyle = app.menuActions.itemByID(132102);

    /* « redefineParagraphStyle.invoke() » => Error « Script not activated. » */

    /* cf. https://forums.adobe.com/thread/1961958 */

    //var redefineParagraphStyle = app.menus[113].menuItems[3];

    /* Marche dans InDesign CC 2015 mais dangereux car peut correspondre à une toute autre commande dans une autre version. */

    

    /* cf. http://kasyan.ho.com.ua/open_menu_item.html https://forums.adobe.com/thread/892886 */

    var redefineParagraphStyle = app.menus.item('$ID/ParaStylePanelPopup').menuItems.item('$ID/Redefine Style');

    

    if (! redefineParagraphStyle.enabled) { throw new Error({

            en: "This script is intended to be used when selecting (or placing the cursor in) some text that has a paragraph style applied "

                +"and some unwanted overriden attributes that will be reverted to the style's values "

                +"for all occurrences where the same overrides affect the same style in the document.",

            fr: "The script est prévu pour être utilisé en sélectionnant (ou plaçant le curseur dans) du texte ayant un style de paragraphe appliqué "

                +"et certains attributs affectés par des remplacements indésirables qui seront rétablis à la valeur du style "

                +"pour toutes les occurrences où les mêmes remplacements affectent le même style dans le document."

    }); }

    

    var myStyle = app.activeDocument.selection[0].insertionPoints[0].appliedParagraphStyle;

    var myStyleName = myStyle.name;

    var myStyleCopy = myStyle.duplicate();

    redefineParagraphStyle.associatedMenuAction.invoke();

    

    myStyle.remove(myStyleCopy);

    myStyleCopy.name = myStyleName;

}

try { 

    app.doScript(

        function() { main(); },

        ScriptLanguage.JAVASCRIPT,

        undefined,

        UndoModes.ENTIRE_SCRIPT,

        File($.fileName).name

    );

} catch(e) { alert(e); }