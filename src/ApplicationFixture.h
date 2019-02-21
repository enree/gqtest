/** @file
 * @brief Application fixture class
 *
 * $Id: $
 */

#pragma once

#include <QObject>

#include <memory>

class QCoreApplication;

namespace gqtest
{

/**
 * Class for providing event loop for tests
 */
class ApplicationFixture : public QObject
{
    Q_OBJECT
public:
    ApplicationFixture();
    ~ApplicationFixture();

    /**
     * Execute event loop for @a intervalMsecs milliseconds
     */
    void wait(uint intervalMsecs);

    /**
     * Execute event loop until @a sender emits @a asignal.
     * Start timer if @a intervalMsecs is greater not equal to zero.
     */
    void exec(QObject* sender, const char* asignal, uint intervalMsecs = 0);

    /**
     * Return true if event loop was quited by timer signal
     */
    bool isTimedOut() const;

private slots:
    void timeout();

private:
    int m_argc;
    char** m_argv;
    std::unique_ptr<QCoreApplication> m_app;
    bool m_timedOut;
};

} // namespace gqtest
