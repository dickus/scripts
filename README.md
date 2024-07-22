# Random Scripts
As the title says, it's my random scripts repository. Here I store scripts that I don't really need but don't want to delete them.

## mvhlink.sh
This script renames every hard link related to provided one. Usage:
```bash
./mvhlink.sh <where_to_search> <hardlink_path> <new_name>
```

**<where_to_search>** — the path may be actual or relative. For script to work in current directory you can use dot symbol:
```bash
<script> . <hardlink_path> <new_name>
```

**<hardlink_path>** — path to any hardlink which mirrors you need to rename. The path may be actual or relative.

**<new_name>** — a new name for all hardlinks.


## gamepad-battery.sh
This script shows you you gamepad id, name and charge. Simply use ./<path_to_script>.
