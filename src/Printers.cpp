/** @file
 * @brief Usefull generic functions for testing (implementation)
 *
 * $Id: $
 */

#include "Printers.h"

#include <QByteArray>
#include <QDateTime>
#include <QRegExp>
#include <QUuid>

#include <boost/algorithm/hex.hpp>

QT_BEGIN_NAMESPACE

void PrintTo(const QString& string, ::std::ostream* stream)
{
    *stream << "\"" << string.toStdString() << "\"";
}

void PrintTo(const QByteArray& array, ::std::ostream* stream)
{
    *stream << "[" << boost::algorithm::hex(array).constData() << "]";
}

void PrintTo(const QRegExp& regexp, std::ostream* stream)
{
    PrintTo(regexp.pattern(), stream);
}

void PrintTo(const QList<int>::const_iterator& iterator, ::std::ostream* stream)
{
    *stream << *iterator;
}

void PrintTo(const QList<int>::iterator& iterator, ::std::ostream* stream)
{
    testing::internal::
        UniversalPrint(QList<int>::const_iterator(iterator), stream);
}

void PrintTo(
    const QMap<int, int>::const_iterator& iterator, ::std::ostream* stream)
{
    *stream << *iterator;
}

void PrintTo(const QUuid& uid, std::ostream* stream)
{
    *stream << uid.toString().toStdString();
}

void PrintTo(const QDateTime& dateTime, ::std::ostream* stream)
{
    PrintTo(dateTime.toString(), stream);
}

void PrintTo(const QModelIndex& index, ::std::ostream* stream)
{
    *stream << "(" << index.row() << ", " << index.column() << ", "
            << index.internalPointer() << ")";
}

void PrintTo(const QMap<int, int>::iterator& iterator, ::std::ostream* stream)
{
    testing::internal::
        UniversalPrint(QMap<int, int>::const_iterator(iterator), stream);
}

QT_END_NAMESPACE
