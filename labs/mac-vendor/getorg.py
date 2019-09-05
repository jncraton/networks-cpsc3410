import sys

def parse_mac(mac):
    """ 
    Parses a MAC address in one of several common formats and returns 
    it as all uppercase with any separators removed.
  
    Example usage:
  
    >>> parse_mac('00:11:22:aa:bb:cc')
    '001122AABBCC'
  
    >>> parse_mac('09-87-65-43-21-ab')
    '0987654321AB'
  
    >>> parse_mac('aabbccddeeff')
    'AABBCCDDEEFF'
  
    Invalid MAC values should raise a ValueError:
  
    >>> parse_mac('xx:xx:xx:xx:xx:xx')
    Traceback (most recent call last):
      ...
    ValueError: xx:xx:xx:xx:xx:xx is not a valid MAC address
  
    >>> parse_mac('001122aabb')
    Traceback (most recent call last):
      ...
    ValueError: 001122aabb is not a valid MAC address
  
    >>> parse_mac('00:11:22:aa:bb:gg')
    Traceback (most recent call last):
      ...
    ValueError: 00:11:22:aa:bb:gg is not a valid MAC address
    """

    pass

def get_mac_oui(mac):
    """
    Returns the Organisationally Unique Identifier (OUI) for a MAC
    address.

    The OUI is the first 3 octets (bytes) of the MAC address.

    Example usage:

    >>> get_mac_oui('00:11:22:aa:bb:cc')
    '001122'

    >>> get_mac_oui('09-87-65-43-21-ab')
    '098765'

    >>> get_mac_oui('aabbccddeeff')
    'AABBCC'
    """

    pass

def get_mac_organization(mac):
    """
    Returns the vendor for a particular MAC address.

    Vendors are found using the registration information provided by the
    IEEE:

    http://standards-oui.ieee.org/oui/oui.csv

    Example usage:

    >>> get_mac_organization('98:AF:65:00:11:22')
    'Intel Corporate'

    >>> get_mac_organization('00:c0:ca:00:11:22')
    'ALFA, INC.'

    >>> get_mac_organization('ff:ff:ff:00:11:22')
    Traceback (most recent call last):
      ...
    IndexError: No organization for ff:ff:ff:00:11:22
    """

    pass

if __name__ == '__main__':
    print(get_mac_organization(sys.argv[1]))