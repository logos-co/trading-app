#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtCore/QUrl>
#include <QtCore/QCoreApplication>
#include <QtCore/QDir>
#include <QtQml/QQmlContext>
#include <QtQml/QQmlComponent>
#include <QtCore/QVariant>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Register application directory as import path
    QString appDir = QCoreApplication::applicationDirPath();
    QString sourcePath = QDir::currentPath() + "/src";
    
    // Add source directories to QML import path
    engine.addImportPath(sourcePath);
    
    // Create demo data for the market view
    QVariantList tokensModel;
    for (int i = 0; i < 20; i++) {
        QVariantMap token;
        token["name"] = QString("Token %1").arg(i + 1);
        token["symbol"] = QString("TKN%1").arg(i + 1);
        token["image"] = "qrc:/img/token.png";  // Default image
        token["currentPrice"] = 100.0 + (i * 10.5);
        token["priceChangePercentage24h"] = (i % 2 == 0) ? 2.5 : -1.8;
        token["totalVolume"] = 1000000.0 + (i * 50000.0);
        token["marketCap"] = 10000000.0 + (i * 1000000.0);
        tokensModel.append(token);
    }

    // Expose context properties required by MarketLayout
    engine.rootContext()->setContextProperty("tokensModel", tokensModel);
    engine.rootContext()->setContextProperty("loading", false);
    engine.rootContext()->setContextProperty("totalTokensCount", 20);
    engine.rootContext()->setContextProperty("currencySymbol", "$");
    
    // Expose required formatting function
    QJSValue formatFn = engine.evaluate(
        "(function(amount, options) { "
        "   options = options || {};"
        "   let formatter = new Intl.NumberFormat('en-US', {"
        "       style: 'decimal',"
        "       minimumFractionDigits: 2,"
        "       maximumFractionDigits: 2"
        "   });"
        "   return formatter.format(amount);"
        "})"
    );
    engine.rootContext()->setContextProperty("fnFormatCurrencyAmount", QVariant::fromValue(formatFn));
    engine.rootContext()->setContextProperty("currentPage", 1);

    // Create and expose utility objects needed by MarketLayout
    QQmlComponent walletUtilsComponent(&engine, "import utils 1.0; QtObject { }");
    QQmlComponent localeUtilsComponent(&engine, "import utils 1.0; QtObject { }");
    
    QObject *walletUtils = walletUtilsComponent.create();
    QObject *localeUtils = localeUtilsComponent.create();
    
    if (walletUtils) {
        engine.rootContext()->setContextProperty("WalletUtils", walletUtils);
    }
    
    if (localeUtils) {
        engine.rootContext()->setContextProperty("LocaleUtils", localeUtils);
    }

    const QUrl url(QStringLiteral("qrc:/Market/MarketLayout.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
} 