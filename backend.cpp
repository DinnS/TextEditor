#include "backend.h"
#include <QUrl>

Backend::Backend(QObject *parent)
    : QObject{parent}
{
    //m_filePath = QCoreApplication::applicationDirPath();
    //m_path.append("/file.txt");
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
    // m_path = value;
    // m_path.remove("file://");
    // emit pathChanged();
    QUrl url(value);
    if (url.isLocalFile()) {
        m_filePath = url.toLocalFile();
    } else {
        m_filePath = value; // Handle or log if the URL is not a local file
    }
    qDebug() << "m_path:" << m_filePath; // Debug output to verify the path
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
