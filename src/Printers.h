/** @file
 * @brief Usefull generic functions for testing (specifications)
 *
 * $Id: $
 */

#pragma once

#include <gtest/gtest-printers.h>

#include <QMap>
#include <QModelIndex>
#include <QPair>
#include <QString>
#include <QUuid>

class QByteArray;
class QDateTime;

/*
 * PrintTo functions must be implemented in namespace of printed objects
 */
QT_BEGIN_NAMESPACE

void PrintTo(const QString& string, ::std::ostream* stream);
void PrintTo(const QRegExp& regexp, ::std::ostream* stream);
void PrintTo(const QByteArray& array, ::std::ostream* stream);
void PrintTo(const QUuid& uid, ::std::ostream* stream);

void PrintTo(const QDateTime& dateTime, ::std::ostream* stream);

template <typename FirstValueType, typename SecondValueType>
void PrintTo(
    const QPair<FirstValueType, SecondValueType>& pair, ::std::ostream* stream)
{
    *stream << "(";
    ::testing::internal::UniversalPrint(pair.first, stream);
    *stream << ", ";
    ::testing::internal::UniversalPrint(pair.second, stream);
    *stream << ")";
}

template <typename ItemsType>
void PrintTo(const QList<ItemsType>& container, ::std::ostream* stream)
{
    typedef QList<ItemsType> Container;

    *stream << "< ";
    for (typename Container::const_iterator it = container.constBegin();
         it != container.constEnd();
         ++it)
    {
        ::testing::internal::UniversalPrint(*it, stream);

        if (it + 1 != container.constEnd())
        {
            *stream << ", ";
        }
    }

    *stream << " >";
}

template <typename KeyType, typename ItemsType>
void PrintTo(const QMap<KeyType, ItemsType>& container, ::std::ostream* stream)
{
    typedef QMap<KeyType, ItemsType> Container;

    *stream << "{ ";
    for (typename Container::const_iterator it = container.constBegin();
         it != container.constEnd();
         ++it)
    {
        *stream << "[ ";
        ::testing::internal::UniversalPrint(it.key(), stream);
        *stream << " ]: ";
        ::testing::internal::UniversalPrint(it.value(), stream);

        if (it + 1 != container.constEnd())
        {
            *stream << ", ";
        }
    }
    *stream << " }";
}

void PrintTo(const QModelIndex& index, ::std::ostream* stream);

QT_END_NAMESPACE

/*
 * PrintTo functions must be implemented in namespace of printed objects
 * and there is problem because of this - template functions for iterators
 * can't be emplemented in their native namespace.
 *
 * But functions below works.
 */
QT_BEGIN_NAMESPACE

void PrintTo(
    const QList<int>::const_iterator& iterator, ::std::ostream* stream);
void PrintTo(const QList<int>::iterator& iterator, ::std::ostream* stream);

void PrintTo(
    const QMap<int, int>::const_iterator& iterator, ::std::ostream* stream);
void PrintTo(const QMap<int, int>::iterator& iterator, ::std::ostream* stream);

QT_END_NAMESPACE

typedef ::testing::
    Types<quint8, quint16, quint32, quint64, qint8, qint16, qint32, qint64>
        IntegerTypes;
