public class Todoer : Object {

    private enum Columns {
        TOGGLE,
        TEXT,
        N_COLUMNS
    }

    private Gtk.Window main_window ;

    private Gtk.ListStore todos_store ;

    public Todoer (Gtk.Builder builder) {
        this.todos_store = builder.get_object ("todos_store") as Gtk.ListStore ;

        this.main_window = builder.get_object ("main_window") as Gtk.Window ;

        this.main_window.set_default_size (500, 500) ;

        this.main_window.show_all () ;
    }

    [CCode (instance_pos = -1)]
    public void on_todo_add(Gtk.Entry entry) {
        Gtk.TreeIter iter ;

        todos_store.append (out iter) ;

        todos_store.set (iter, Columns.TOGGLE, false, Columns.TEXT, entry.text) ;

        entry.text = "" ;
    }

    [CCode (instance_pos = -1)]
    public void on_completed_clicked(Gtk.CellRendererToggle cell, string path) {
        Gtk.TreeIter iter ;

        todos_store.get_iter_from_string (out iter, path) ;

        todos_store.set (iter, Columns.TOGGLE, !cell.active) ;
    }

    [CCode (instance_pos = -1)]
    public void on_todo_edited(Gtk.CellRendererText cell, string path, string newText) {
        Gtk.TreeIter iter ;

        todos_store.get_iter_from_string (out iter, path) ;

        todos_store.set (iter, Columns.TEXT, newText) ;
    }

    public static int main(string[] args) {
        Gtk.init (ref args) ;

        try {
            var builder = new Gtk.Builder () ;

            builder.add_from_resource ("/com/github/devhammed/todoer/ui/todoer.glade") ;

            builder.connect_signals (new Todoer (builder)) ;

            Gtk.main () ;
        } catch ( Error e ) {
            stderr.printf ("Could not load UI: %s\n", e.message) ;

            return 1 ;
        }

        return 0 ;
    }

}
