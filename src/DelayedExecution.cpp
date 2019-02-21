/** @file
 * @brief
 *
 * @ingroup
 *
 * @copyright  (C) 2016 PKB RIO Design Department
 *
 * $Id: $
 */

#include "DelayedExecution.h"

#include <QTimer>

namespace gqtest
{

DelayedExecution::DelayedExecution()
{
    QTimer::singleShot(0, this, SLOT(execute()));
}

void DelayedExecution::addAction(DelayedExecution::Function action)
{
    m_actions.emplace_back(action);
}

void DelayedExecution::sendComplete()
{
    emit complete();
}

void DelayedExecution::execute()
{
    for (const auto& action: m_actions)
    {
        action();
    }
}

} // namespace gqtest