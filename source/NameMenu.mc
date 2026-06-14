import Toybox.Lang;
import Toybox.WatchUi;

// Pick a name for the pet from a preset list (free-text entry is impractical on
// a watch). Shown right after adopting, and reachable again from Settings.
function buildNameMenu(pet as Pet) as WatchUi.Menu2 {
    var menu = new WatchUi.Menu2({ :title => "Name your pet" });
    var names = ["Mochi", "Pixel", "Biscuit", "Nova", "Pip", "Tofu", "Suki", "Ziggy", "Coco", "Bean", "Sprout", "Dash"];
    for (var i = 0; i < names.size(); i++) {
        menu.addItem(new WatchUi.MenuItem(names[i], null, names[i], null));
    }
    menu.addItem(new WatchUi.MenuItem("Keep " + Pet.petTypeName(pet.petType), "Default", :keep, null));
    return menu;
}

class NameMenuDelegate extends WatchUi.Menu2InputDelegate {
    var mainView as TamagotchiView;

    function initialize(view as TamagotchiView) {
        Menu2InputDelegate.initialize();
        mainView = view;
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        var id = item.getId();
        if (!(id == :keep)) {
            mainView.pet.name = id as String;
            StorageManager.savePet(mainView.pet);
            PetComplication.publish(mainView.pet);
        }
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        mainView.afterNaming();
    }

    function onBack() as Void {
        // Backing out keeps the default species name.
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        mainView.afterNaming();
    }
}
