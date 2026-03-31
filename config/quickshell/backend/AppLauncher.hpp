#include <qt6/QtQmlIntegration/qqmlintegration.h>

#include <qt6/QtCore/QObject>
#include <qt6/QtCore/QString>
#include <qt6/QtQmlDebug/QtQmlDebug>

class App : public QObject {
  Q_OBJECT
  Q_PROPERTY(QString name READ name NOTIFY nameChanged)
  Q_PROPERTY(QString icon READ icon NOTIFY iconChanged)
  Q_PROPERTY(QString description READ description NOTIFY descriptionChanged)
  Q_PROPERTY(QString exec READ exec NOTIFY execChanged)

 public:
  App(QString name, QString icon, QString desc, QString exec) {
    m_name = name;
    m_icon = icon;
    m_desc = desc;
    m_exec = exec;
  }
  QString name() const { return m_name; }
  QString icon() const { return m_icon; }
  QString description() const { return m_desc; }
  QString exec() const { return m_exec; }

 signals:
  void nameChanged();
  void iconChanged();
  void descriptionChanged();
  void execChanged();

 private:
  QString m_name;
  QString m_icon;
  QString m_desc;
  QString m_exec;
};

class AppLauncherBackend : public QObject {
  Q_OBJECT
  QML_ELEMENT
  Q_PROPERTY(QList<App*> appList READ appList NOTIFY appListChanged)

 public:
  AppLauncherBackend();
  QList<App*> appList() const { return m_filteredAppList; };
  Q_INVOKABLE void updateAppList() {
    parseAppList();
    emit appListChanged();
  }
  Q_INVOKABLE void filterAppList(const QString& filter);

 signals:
  void appListChanged();

 private:
  QList<App*> m_appList;
  QList<App*> m_filteredAppList;
  void parseAppList();
};
