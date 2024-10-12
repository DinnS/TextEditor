#include "backend.h"
#include <QUrl>

// Constructor
Backend::Backend(QObject *parent)
    : QObject{parent}
{
}

// Getter
QString Backend::getFilePath()
{
    return m_filePath;
}

QString Backend::getFileContent()
{
    QFile file(m_filePath);
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Could not read file!";
        return "";
    }

    QTextStream stream(&file);
    QString value = stream.readAll();
    file.close();
    return value;
}

// Setter
void Backend::setFilePath(QString value)
{
    QUrl url(value);
    if (url.isLocalFile()) {
        m_filePath = url.toLocalFile();
    } else {
        // Handle or log if the URL is not a local file
        m_filePath = value;
    }
    // Debug output to verify the path
    qDebug() << "m_filePath:" << m_filePath;
    emit filePathChanged();
}

void Backend::setFileContent(QString value)
{
    QFile file(m_filePath);
    if(!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Could not write file!";
        return;
    }

    QTextStream stream(&file);
    stream << value;
    stream.flush();
    file.close();

    emit fileContentChanged();
}
