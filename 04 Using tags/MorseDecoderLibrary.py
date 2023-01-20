import serial


class MorseDecoderLibrary(object):
    ''' Library for interacting with morse sender and decoder
    '''
    ROBOT_LIBRARY_SCOPE = 'SUITE'

    def __init__(self, sender_com, decoder_com):
        self._sender = serial.Serial(sender_com, 115200, timeout=1)
        self._decoder = serial.Serial(decoder_com, 115200, timeout=20)

    def set_speed(self, speed):
        self._sender.write(bytes('wpm ' + speed + '\n', 'utf-8'))

    def send_text(self, text):
        self._decoder.reset_input_buffer()
        self._sender.write(bytes("text " + text + '\n', 'utf-8'))

    def speed_should_be(self, expected_speed):
        text = self._decoder.readline().strip().decode('utf-8')
        speed = int(text.split()[2])
        if speed != int(expected_speed):
            raise AssertionError(
                'Expected: ' + str(expected_speed) + ' got: ' + str(speed) + ' line: ' + text)

    def speed_should_be_relaxed(self, expected_speed):
        text = self._decoder.readline().strip().decode('utf-8')
        speed = int(text.split()[2])
        speed_min = (int(expected_speed) * 0.90)
        speed_max = (int(expected_speed) * 1.10)
        if not (speed_min <= speed <= speed_max):
            raise AssertionError('Expected:' + str(speed_min) + ' - ' +
                                 str(speed_max) + ' and got: ' + str(speed) + ' line: ' + text)

    def text_should_be(self, expected_text):
        text = self._decoder.readline().strip().decode('utf-8')
        if text != expected_text:
            raise AssertionError(
                'Expected: ' + expected_text + ' got: ' + text)
