#include "AppLauncher.hpp"

#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <string>

using std::string, std::getline;
namespace fs = std::filesystem;

AppLauncherBackend::AppLauncherBackend() { parseAppList(); }

void AppLauncherBackend::parseAppList() {
  const string directories[] = {
      "/usr/share/applications/", "/usr/local/share/applications",
      string(getenv("HOME")) + "/.local/share/applications"};
  for (string path : directories)
    for (const fs::directory_entry& entry : fs::directory_iterator(path)) {
      if (entry.is_regular_file() && entry.path().extension() == ".desktop") {
        std::ifstream file(entry.path().string());
        if (file.is_open()) {
          string str, name, icon, desc, exec;
          while (getline(file, str) && (name.empty() || icon.empty() ||
                                        desc.empty() || exec.empty())) {
            if (!str.find("Name="))
              name = str.substr(5);
            else if (!str.find("Icon="))
              icon = str.substr(5);
            else if (!str.find("Comment="))
              desc = str.substr(8);
            else if (!str.find("Exec=")) {
              int pos = 0;
              while ((pos = str.find('%', pos)) != string::npos)
                str.erase(pos, 2);
              exec = str.substr(5);
            }
          }
          m_appList.append(new App(
              QString::fromStdString(name), QString::fromStdString(icon),
              QString::fromStdString(desc), QString::fromStdString(exec)));
          file.close();
        }
      }
    }
  m_filteredAppList = m_appList;
}

void AppLauncherBackend::filterAppList(const QString& filter) {
  m_filteredAppList.clear();
  for (App* app : m_appList)
    if (app->name().contains(filter, Qt::CaseInsensitive))
      m_filteredAppList.append(app);
  emit appListChanged();
}
