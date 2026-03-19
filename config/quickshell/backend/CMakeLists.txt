qt_add_qml_module(${PROJECT_NAME}
  URI Quickshell.Backend
  VERSION 1.0
  SOURCES
    AppLauncher.cpp
  OUTPUT_DIRECTORY "$ENV{HOME}/.local/lib/qt6/qml/Quickshell/Backend"
)
