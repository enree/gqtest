/** @file
 * @brief Application fixture class
 *
 * $Id: $
 */

#include "ApplicationFixture.h"

#include <QCoreApplication>
#include <QTimer>

namespace gqtest
{

namespace
{

char arg1[] = "gtests";
char* argv[] = { arg1, nullptr };

} // namespace

ApplicationFixture::ApplicationFixture()
    : m_argc(1)
    , m_argv(argv)
    , m_app(std::make_unique<QCoreApplication>(m_argc, m_argv))
    , m_timedOut(false)
{
}

ApplicationFixture::~ApplicationFixture() = default;

void ApplicationFixture::wait(uint intervalMsecs)
{
    if (intervalMsecs > 0)
    {
        QTimer::singleShot(intervalMsecs, this, SLOT(timeout()));
    }
    m_app->exec();
}

void ApplicationFixture::exec(
    QObject* sender, const char* asignal, uint intervalMsecs)
{
    Q_ASSERT(sender);
    QObject::connect(sender, asignal, m_app.get(), SLOT(quit()));
    wait(intervalMsecs);
}

bool ApplicationFixture::isTimedOut() const
{
    return m_timedOut;
}

void ApplicationFixture::timeout()
{
    m_timedOut = true;
    m_app->quit();
}

} // namespace gqtest
