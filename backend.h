#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QCoreApplication>
#include <QFile>
#include <QTextStream>
#include <QDebug>

class Backend : public QObject
{
    Q_OBJECT

    // Macros
    Q_PROPERTY(QString filePath READ getFilePath WRITE setFilePath NOTIFY filePathChanged)
    Q_PROPERTY(QString fileContent READ getFileContent WRITE setFileContent NOTIFY fileContentChanged)

public:
    explicit Backend(QObject *parent = nullptr);

    // Getters
    QString getFilePath();
    QString getFileContent();

    // Setters
    void setFilePath(QString value);
    void setFileContent(QString value);

signals:
    // Signals
    void filePathChanged();
    void fileContentChanged();

private:
    // Store variables
    QString m_filePath;
};

#endif // BACKEND_H
