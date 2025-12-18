# FreeFileSync

A lightweight, browser-accessible GUI for folder comparison and file synchronization. This container runs the FreeFileSync desktop application inside a minimal container image and exposes a web/VNC-based UI so you can configure, run and schedule sync jobs from your browser.

---

## Key features

* Browser-accessible GUI (default container port: **5800**)
* Optional VNC access (default container port: **5900**) for the full desktop
* Persistent configuration stored under `/config` (mapped to the app data folder)
* Support for scheduled batch jobs and saved sync configurations
* Runs as non-root user via `USER_ID` / `GROUP_ID` env vars

---

<!-- ## Smritimegh notes

* Image used: `jlesage/freefilesync:latest`.
* Default internal web UI port: `5800`. Runtipi `config.json` exposes a configurable host port (recommended: set a unique `APP_PORT` during install to avoid clashes).
* Persistent folders (recommended):

  * `${APP_DATA_DIR}/data/freefilesync` → container `/config` (holds settings, saved jobs)
  * `${APP_DATA_DIR}/storage` → container `/storage` (convenient mountpoint for synced data)

---

## Quick install (Runtipi appstore)

1. Add the appstore entry (place `config.json`, `docker-compose.json`, and `docker-compose.yml` under `apps/<your-store>/freefilesync/`).
2. Commit and push the appstore repository, then add it in the Runtipi UI.
3. Install the app and set `Host port for web UI` (the `APP_PORT`) to an unused port on your host.
4. After launch, open `http://<host-ip>:<APP_PORT>` in your browser to access the FreeFileSync GUI.

---

## Environment variables and runtime settings

* `USER_ID` — UID to run the container process (default `1000`).
* `GROUP_ID` — GID to run the container process (default `1000`).
* `APP_PORT` — Host port mapped to container `5800` (set via install form or environment overrides).
* `FFS_VNC_PORT` — Host port mapped to container `5900` if you need VNC.

---

## Recommended port guidance

Pick a high-numbered, unused TCP port (e.g., `5800`, `5860`, `5960`, etc.) when installing via Runtipi so the GUI does not conflict with other services. Verify with `ss -tulpn` or `docker ps` on the host before committing the port.

--- -->

## Troubleshooting

* **GUI not reachable:** confirm the app container is running and that `APP_PORT` is correctly mapped to container port `5800`.
* **Permissions errors accessing host storage:** ensure mounts are owned or accessible by the container's `USER_ID` / `GROUP_ID` or use `chown` to adjust ownership on the host.
* **Settings not persisting after restart:** verify the `/config` volume points at `${APP_DATA_DIR}/data/freefilesync` and that the host directory is writable.

---

## Links

* FreeFileSync project: [https://freefilesync.org/](https://freefilesync.org/)
* jlesage FreeFileSync image and docs: [https://hub.docker.com/r/jlesage/freefilesync](https://hub.docker.com/r/jlesage/freefilesync)

---
