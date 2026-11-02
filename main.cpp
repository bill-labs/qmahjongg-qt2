#include <kapp.h>
#include <kcmdlineargs.h>
#include <kaboutdata.h>
#include "kmahjongg.h"
#include "version.h"

int main(int argc, char **argv)
{
    KAboutData aboutData(
        "qmahjongg",
        "QMahjongg",
        QMAHJONGG_VERSION,
        "Mahjongg tile matching game",
        KAboutData::License_GPL,
        "(c) 1997, Mathias Mueller"
    );
    aboutData.addAuthor("Mathias Mueller", "", "in5y158@public.uni-hamburg.de");

    KCmdLineArgs::init(argc, argv, &aboutData);
    KApplication app(argc, argv);

    QMahjonggWidget *w = new QMahjonggWidget();
    app.setMainWidget(w);
    w->show();

    return app.exec();
}
