# QMahjongg for Qt2 - Makefile
# Ported from KDE2 to pure Qt2 using qt2-kde-mini

PREFIX ?= /opt/gnux
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share/qmahjongg
QTDIR ?= $(PREFIX)/qt2
QT2KDEMINI ?= ../qt2-kde-mini
MOC = $(QTDIR)/bin/moc

CXX = g++
CXXFLAGS = -O3 -fomit-frame-pointer -Wall -Wno-parentheses -D_UNIXWARE -DPREFIX=\"$(PREFIX)\" -I$(QTDIR)/include -I$(QT2KDEMINI)/include -I.
LDFLAGS = -L$(QTDIR)/lib -L$(QT2KDEMINI) -L$(PREFIX)/lib -lqt -lqt2kdemini -lgnux

TARGET = qmahjongg

# Source files
SOURCES = main.cpp kmahjongg.cpp Background.cpp BoardLayout.cpp GameNum.cpp GameTimer.cpp HighScore.cpp Preferences.cpp PrefsDlg.cpp Preview.cpp Progress.cpp Tileset.cpp

# Moc files (for classes with Q_OBJECT)
MOC_SOURCES = moc_kmahjongg.cpp moc_GameNum.cpp moc_GameTimer.cpp moc_HighScore.cpp moc_PrefsDlg.cpp moc_Preview.cpp moc_Progress.cpp

# Objects
OBJECTS = $(SOURCES:.cpp=.o) $(MOC_SOURCES:.cpp=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

moc_%.cpp: %.h
	$(MOC) $< -o $@

# Moc dependencies
kmahjongg.o: moc_kmahjongg.cpp
GameNum.o: moc_GameNum.cpp
GameTimer.o: moc_GameTimer.cpp
HighScore.o: moc_HighScore.cpp
PrefsDlg.o: moc_PrefsDlg.cpp
Preview.o: moc_Preview.cpp
Progress.o: moc_Progress.cpp

clean:
	rm -f $(OBJECTS) $(MOC_SOURCES) $(TARGET)

install:
	mkdir -p $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(DATADIR)/pics
	cp $(TARGET) $(DESTDIR)$(BINDIR)/
	cp pics/*.layout pics/*.bgnd pics/*.tileset pics/*.theme pics/*.xpm pics/*.png $(DESTDIR)$(DATADIR)/pics/

.PHONY: all clean install
